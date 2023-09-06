import Foundation
import UIKit.UIImage

protocol TrendingViewPresenter {
    init(view:TrendingViewProtocol)
    func loadMoreTrendings()
}

class TrendingPresenter: TrendingViewPresenter {
    
    unowned let view: TrendingViewProtocol
    
    required init(view: TrendingViewProtocol) {
        self.view = view
    }
    
    func loadMoreTrendings() {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.trendingsRecipesPlusFive){
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
                        
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular ?? false), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: authorAvatar(authorName: recipe.sourceName!), authorName: recipe.sourceName, isSavedToFavorite: false, coockingSteps: steps, ingredients: ingredients, categoryName: ""))
                    }
                    view.addTenMoreTrendings(dataArray)
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
}
