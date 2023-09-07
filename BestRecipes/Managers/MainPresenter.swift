import UIKit.UIImage
import Foundation

protocol HomeViewPresenter {
    init(view: HomeViewProtocol)
    func loadTrendindsData()
    func loadMainCourseData()
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int)
    func loadSearchRequestData(searchText: String)
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
                        
                        var steps : [String] = []
                        
                        if recipe.analyzedInstructions.count != 0 {
                            for step in recipe.analyzedInstructions[0].steps {
                                steps.append(step.step)
                            }
                        } else {
                            steps = ["Sorry, here is no instruction. You should cook like you feel))"]
                        }

                        
                        var ingredients : [(id: Int, name: String, image: String, amount: Double, unit: String)] = []
                        
                        for ingredient in  recipe.extendedIngredients {
                            
                            var ingImage : String = ""
                            
                            if ingredient.image != "" {
                                ingImage = ingredient.image
                            } else {
                                ingImage = "https://img.freepik.com/free-vector/no-data-concept-illustration_114360-626.jpg?w=1480&t=st=1694025367~exp=1694025967~hmac=7969e35b446f38bbe533178d4a7f16cdee5673be9c1502f32aebc46b0ea19868"
                            }
                            
                            ingredients.append((id: ingredient.id, name: ingredient.name, image: ingImage, amount: ingredient.amount, unit: ingredient.unit))
                        }
                        
                        
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false, coockingSteps: steps, ingredients: ingredients, categoryName: recipe.sourceName!))
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
                        var steps : [String] = []
                        
                            for step in recipe.analyzedInstructions[0].steps {
                            steps.append(step.step)
                        }
                        
                        var ingredients : [(id: Int, name: String, image: String, amount: Double, unit: String)] = []
                        
                        for ingredient in  recipe.extendedIngredients {
                            ingredients.append((id: ingredient.id, name: ingredient.name, image: ingredient.image, amount: ingredient.amount, unit: ingredient.unit))
                        }
                        
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false, coockingSteps: steps, ingredients: ingredients, categoryName: "main%20course"))
                    }
                    view.preloadSetupPopulars(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
    
    func loadPopularsWithCategoryes(categoryes: String, categoryCount: Int) {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.popularCategoryes + "&number=\(categoryCount * 5)" + "&tags=\(categoryes)" ){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        
                        var steps : [String] = []
                        
                        for step in recipe.analyzedInstructions[0].steps {
                            steps.append(step.step)
                        }
                        
                        var ingredients : [(id: Int, name: String, image: String, amount: Double, unit: String)] = []
                        
                        for ingredient in  recipe.extendedIngredients {
                            ingredients.append((id: ingredient.id, name: ingredient.name, image: ingredient.image, amount: ingredient.amount, unit: ingredient.unit))
                        }
                        
                        
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false, coockingSteps: steps, ingredients: ingredients, categoryName: categoryes))
                    }
                    view.updatePopulars(dataArray)
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
        case "blogspot.com":
            return UIImage(named: "blogspot.com")!
        case "Food and Spice":
            return UIImage(named: "Food and Spice")!
        default:
            return UIImage(named: "emptyAvatar")!
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
    
    func loadSearchRequestData(searchText: String) {
        Task {
            do {
                if let results = try await NetworkManager.shared.fetchResultsArrayData(from: DataManager.shared.searchURL + "&query=\(searchText)") {
                    var dataArray : [RecipeDataModel] = []
                    for result in results.results {
                        var steps : [String] = []
                        
                        for step in result.analyzedInstructions[0].steps {
                            steps.append(step.step)
                        }
                        
                        var ingredients : [(id: Int, name: String, image: String, amount: Double, unit: String)] = []
                        
                        for ingredient in  result.extendedIngredients {
                            ingredients.append((id: ingredient.id, name: ingredient.name, image: ingredient.image, amount: ingredient.amount, unit: ingredient.unit))
                        }
                        
                        dataArray.append(RecipeDataModel(recipeId: result.id, recipeImage: result.image, recipeRating: figureRatingValue(isPopular: result.veryPopular!), cookDuration: "\(result.readyInMinutes ?? 0)", recipeTitle: result.title, authorAvatar: UIImage(systemName: "plus")!, authorName: result.sourceName, isSavedToFavorite: false, coockingSteps: steps, ingredients: ingredients, categoryName: result.sourceName!))
                    }
                    view.updateSearchData(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }
    
}
