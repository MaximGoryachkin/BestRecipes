//
//  DataManager.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 28.08.2023.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    let baseURL = "https://api.spoonacular.com/recipes/"
    let apiKey = "3f49d203dce9450582765f268e3771b1"
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
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=15"
    }
    
    var trendingsRecipesPlusFive: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5"
    }
    
    var mainCoursePopulars: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey + "&number=5" + "&tags=main%20course"
    }
    
    var popularCategoryes: String {
        baseURL + GetRecipe.random.rawValue + "?apiKey=" + apiKey
    }
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
