//
//  TestPresenter.swift
//  BestRecipes
//
//  Created by Максим Горячкин on 30.08.2023.
//

import Foundation

protocol TestViewPresenter {
    init(view: TestViewProtocol)
    func showImage()
    func showNewImage()
    func saveDataToCache(with data: Data, and responce: URLResponse)
    func getDataFromCache(from url: URL) -> Data?
    func saveRecipe()
}

class TestPresenter: TestViewPresenter {
    
    unowned let view: TestViewProtocol
    
    required init(view: TestViewProtocol) {
        self.view = view
    }
    
    func showImage() {
        Task {
            do {
                if let recipe = try await NetworkManager.shared.fetchData(from: DataManager.shared.recipeURL) {
//                    view.setImage(recipe.image)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func showNewImage() {
        
        Task {
            if let recipe = try await NetworkManager.shared.fetchData(from: DataManager.shared.recipeURL) {
//                view.setImage(recipe.image)
            }
        }
        
    }

    func saveDataToCache(with data: Data, and responce: URLResponse) {
        guard let url = responce.url else { return }
        let request = URLRequest(url: url)
        let cachedResponce = CachedURLResponse(response: responce, data: data)
        URLCache.shared.storeCachedResponse(cachedResponce, for: request)
    }
    
    func getDataFromCache(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponce = URLCache.shared.cachedResponse(for: request) {
            return cachedResponce.data
        } else {
            return nil
        }
    }
    
    func saveRecipe() {
        
    }
}
