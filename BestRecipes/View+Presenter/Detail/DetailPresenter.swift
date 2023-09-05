import Foundation

protocol DetailViewPresenter {
    init(view: DetailViewProtocol)
    func getRecipeData(_ recipeInfo: RecipeDataModel)
    func sendRecipeData()
}

class DetailPresenter: DetailViewPresenter {
    
    unowned let view: DetailViewProtocol
    
    required init(view: DetailViewProtocol) {
        self.view = view
    }
    
    private var recipeInfoData: RecipeDataModel?
    
    
    func getRecipeData(_ recipeInfo: RecipeDataModel) {
        self.recipeInfoData = recipeInfo
    }
    
    func sendRecipeData() {
//        view.retreveRecipeData(recipeInfoData!)
    }

}
