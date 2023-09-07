//
//  iscoverPresenter.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 01.09.2023.
//

import Foundation

protocol DiscoverPresentorProtocol {
    var recipes: [RecipeDataModel] { get set }
    func updateRecipes()
    init(view: DiscoverViewProtocol)
}

class DiscoverPresenter: DiscoverPresentorProtocol {
    unowned let view: DiscoverViewProtocol!
    var recipes = [RecipeDataModel]()
    
    func updateRecipes() {
        recipes = []
        for key in DataManager.shared.arrayRecipes.keys {
            guard let recipe = DataManager.shared.arrayRecipes[key] else { return }
            recipes.append(recipe)
        }
        view.updateCollection(with: recipes)
    }
    
    required init(view: DiscoverViewProtocol) {
        self.view = view
    }
    
}
