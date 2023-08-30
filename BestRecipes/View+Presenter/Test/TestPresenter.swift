//
//  TestPresenter.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 30.08.2023.
//

protocol TestViewPresenter {
    init(view: TestViewProtocol, recipe: Recipe)
    func showTitle()
    func showNewTitle()
}

class TestPresenter: TestViewPresenter {
    
    unowned let view: TestViewProtocol
    var recipe: Recipe
    
    required init(view: TestViewProtocol, recipe: Recipe) {
        self.view = view
        self.recipe = recipe
    }
    
    func showTitle() {
        view.setLabel(recipe.title)
    }
    
    func showNewTitle() {
        Task {
            if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.randomRecipe) {
                view.setLabel(recipes.recipes[0].title)
            }
        }
    }

}
