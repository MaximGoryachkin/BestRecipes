//
//  NetworkManager.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 28.08.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with complition: @escaping (Recipe) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let recipes = try JSONDecoder().decode(Recipe.self, from: data)
                DispatchQueue.main.async {
                    complition(recipes)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchArrayData(from url: String?, with complition: @escaping ([Recipe]) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            do {
                let recipes = try JSONDecoder().decode(Recipes.self, from: data)
                DispatchQueue.main.async {
                    complition(recipes.recipes)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchData(from url: String?) async throws -> Recipe? {
        guard let stringURL = url else { return nil }
        guard let url = URL(string: stringURL) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipe = try JSONDecoder().decode(Recipe.self, from: data)
        return recipe
    }
    
    func fetchArrayData(from url: String?) async throws -> Recipes? {
        guard let stringURL = url else { return nil }
        guard let url = URL(string: stringURL) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(Recipes.self, from: data)
        return recipes
    }
    
}
