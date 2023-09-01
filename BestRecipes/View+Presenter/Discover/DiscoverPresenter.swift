//
//  iscoverPresenter.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 01.09.2023.
//

import Foundation

protocol DiscoverPresentorProtocol {
    var recipesID: Set<Int> { get set }
    var pecipes: [Recipe] { get set }
    func updateRecipes()
    func fetchRecipesFromStorage()
    init(recipesID: Set<Int>)
}

class DiscoverPresenter: DiscoverPresentorProtocol {
    var recipesID: Set<Int>
    
    var pecipes = [Recipe]()
    
    func updateRecipes() {
        
    }
    
    func fetchRecipesFromStorage() {
        
    }
    
    required init(recipesID: Set<Int>) {
        self.recipesID = recipesID
    }

}
