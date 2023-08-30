//
//  Ingridients.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 28.08.2023.
//

struct Ingredient: Codable {
    let id: Int
    let name: String
    let amount: Double
    let unit: String
}
