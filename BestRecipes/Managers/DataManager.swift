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
    let apiKey = ""
    let number = 1
    let id = 100
    
    private init() {}
    
    var randomRecipe: String {
        baseURL + GetRecipe.random.rawValue + apiKey + "&number=\(number)"
    }
    
    var recipeURL: String {
        baseURL + "\(id)/" + GetRecipe.information.rawValue + apiKey
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
