

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    let baseURL = "https://api.spoonacular.com/recipes/"
    let apiKey = "96e9dcad31254d1fb414fd818ca07ad0"
    // 0b966a75106540f88014b83398f69da5
//    "96e9dcad31254d1fb414fd818ca07ad0"
// e2fef51d8304448cba077f7f456da693
// 3f49d203dce9450582765f268e3771b1
    let number = 1
    let id = 100
    
    private init() {}
    
    var randomRecipe: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=\(number)"
    }
    
    var recipeURL: String {
        baseURL + "\(id)/" + GetRecipe.information.rawValue + "?apiKey=" + apiKey
    }
    
    var trendingsRecipes: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=15" + "&instructionsRequired=true"
    }
    
    var trendingsRecipesPlusFive: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5" + "&instructionsRequired=true"
    }
    
    var mainCoursePopulars: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5" + "&tags=main%20course"
    }
    
    var popularCategoryes: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey
    }
    
    var searchURL : String {
        baseURL + "complexSearch" + "?apiKey=" + apiKey + "&addRecipeInformation=true" + "&number=20" + "&fillIngredients=true" + "&instructionsRequired=true"
    }
    
    var arrayRecipes = [Int : RecipeDataModel]()
}

enum GetRecipe: String {
    case information
    case similar
    case random
    case autocomplete
}

enum MealType: String, CaseIterable {
    case mainCource = "main course"
    case sideDish = "side dish"
    case dessert
    case appetizer
    case salad
    case bread
    case breakfast
    case soup
    case beverage
    case sauce
    case marinade
    case fingerfood
    case snack
    case drink
}
