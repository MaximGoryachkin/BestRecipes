
import Foundation

protocol HomeViewPresenter {
    init(view: HomeViewProtocol)
    func loadTrendindsData()
    func showImage()
    func showNewImage()
    func saveDataToCache(with data: Data, and responce: URLResponse)
    func getDataFromCache(from url: URL) -> Data?
    func saveRecipe()
}

class HomePresenter: HomeViewPresenter {
    
    unowned let view: HomeViewProtocol
    
    required init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func loadTrendindsData() {
        Task {
            do {
                if let recipes = try await NetworkManager.shared.fetchArrayData(from: DataManager.shared.trendingsRecipes){
                    var dataArray : [RecipeDataModel] = []
                    for recipe in recipes.recipes {
                        dataArray.append(RecipeDataModel(recipeId: recipe.id, recipeImage: recipe.image, recipeRating: figureRatingValue(isPopular: recipe.veryPopular!), cookDuration: "\(recipe.readyInMinutes ?? 00)", recipeTitle: recipe.title, authorAvatar: nil, authorName: recipe.sourceName, isSavedToFavorite: false))
                    }
                    view.setTrendingsData(dataArray)
                }
            } catch {
                print(error)
            }
        }
    }

    
    private func figureRatingValue(isPopular: Bool) -> String {
        if isPopular {
            let result = Float.random(in: 3.800 ... 5.000)
            return String(format: "%.1f", result)
        } else {
            let result = Float.random(in: 1.000 ... 3.700)
            return String(format: "%.1f", result)
        }
    }
    
    func showImage() {
        Task {
            do {
                if let recipe = try await NetworkManager.shared.fetchData(from: DataManager.shared.recipeURL) {
                    view.setImage(recipe.image)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func showNewImage() {
        
        Task {
            if let recipe = try await NetworkManager.shared.fetchData(from: DataManager.shared.recipeURL) {
                view.setImage(recipe.image)
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
