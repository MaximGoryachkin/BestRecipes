//
//  iscoverPresenter.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 01.09.2023.
//

import Foundation

protocol DiscoverPresentorProtocol {
    var recipes: [Recipe] { get set }
    func updateRecipes()
    func fetchRecipesFromStorage()
    init(view: DiscoverViewProtocol)
}

class DiscoverPresenter: DiscoverPresentorProtocol {
    unowned let view: DiscoverViewProtocol!
    var recipes = [Recipe]()
    
    func updateRecipes() {
        fetchRecipesFromStorage()
        view.updateCollection(with: recipes)
    }
    
    internal func fetchRecipesFromStorage() {
//        guard let recipesID = UserDefaults.standard.array(forKey: Constants.recipesID) else { return }
//        recipesID.forEach {
//            guard let recipe = UserDefaults.standard.object(forKey: $0 as! String) else { return }
//            recipes.append(recipe as! Recipe)
//        }
    }
    
    required init(view: DiscoverViewProtocol) {
        self.view = view
    }
    
}
