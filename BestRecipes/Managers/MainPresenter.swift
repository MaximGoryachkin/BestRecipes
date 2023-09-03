
import Foundation

protocol HomeViewPresenter {
    init(view: HomeViewProtocol)
    func loadTrendindsData()
    func loadMainCourseData()
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int)
}

class HomePresenter: HomeViewPresenter {
    
    unowned let view: HomeViewProtocol
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func loadTrendindsData() {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.trendingsRecipes){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.setTrendingsData(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func loadMainCourseData() {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.mainCoursePopulars){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.preloadSetupPopulars(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int) {
        
//        var categoryesNames: String = ""
//        
//        if categoryes.count != 0 {
//            for string in categoryes.dropLast() {
//                categoryesNames += "\(string),"
//            }
//            if let lastString = categoryes.last {
//                categoryesNames += lastString
//            }
//        }
//            
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.popularCategoryes + "&number=\(categoryCount * 5)" + "&tags=\(categoryes)" ){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.updatePopulars(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }

    
    private func figureRatingValue(isPopular: Bool) -> String {
        if isPopular {
            let result = Float.random(in: 3.800 ... 5.000)
            return String(format: "%.1f", result)
        } else {
            let result = Float.random(in: 1.000 ... 3.700)
            return String(format: "%.1f", result)
        }
    }
}
