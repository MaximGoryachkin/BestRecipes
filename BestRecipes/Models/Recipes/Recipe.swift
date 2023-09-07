//
//  Recipe.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 28.08.2023.
//

struct Recipe: Codable {
    let extendedIngredients: [Ingredient]?
    let id: Int?
    let title: String?
    let readyInMinutes: Int?
    let servings: Int?
    let image: String
    let summary: String?
    let analyzedInstructions: [Instruction]?
    let veryPopular: Bool?
    let sourceName: String?
}
