import UIKit.UIImage
import Foundation

protocol HomeViewPresenter {
    init(view: HomeViewProtocol)
    func loadTrendindsData()
    func loadMainCourseData()
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int)
    func loadFiveEditionalsTrendingsItems()
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
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.setTrendingsData(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func loadFiveEditionalsTrendingsItems() {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.trendingsRecipesPlusFive){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.addFiveTrendings(dataArray)
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
                    var dataArray : [PopularsRecipesDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(PopularsRecipesDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false, categoryName: "main%20course"))
                    }
                    view.preloadSetupPopulars(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func authorAvatar(authorName: String) -> UIImage {
        switch authorName {
        case "Foodista":
            return UIImage(named: "Foodista")!
        case "foodista.com":
            return UIImage(named: "foodista.com")!
        case "Pink When" , "pinkwhen.com":
            return UIImage(named: "pinkwhen")!
        case "Afrolems" , "afrolems.com":
            return UIImage(named: "Afrolems")!
        case "Full Belly Sisters":
            return UIImage(named: "Full_Belly_Sisters")!
        default:
            return UIImage(named: "emptyAvatar")!
        }
    }
    
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int) {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.popularCategoryes + "&number=\(categoryCount * 5)" + "&tags=\(categoryes)" ){
                    var dataArray : [PopularsRecipesDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(PopularsRecipesDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false, categoryName: categoryes))
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
            let result = Float.random(in: 3.810 ... 5.000)
            return String(format: "%.1f", result)
        } else {
            let result = Float.random(in: 1.110 ... 3.700)
            return String(format: "%.1f", result)
        }
    }
}
