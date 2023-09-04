import Foundation
import UIKit.UIImage

struct RecipeDataModel {
    let recipeId : Int
    let recipeImage : String?
    let recipeRating : String?
    let cookDuration : String?
    let recipeTitle : String?
    let authorAvatar : UIImage
    let authorName : String?
    let isSavedToFavorite : Bool?
}

struct PopularsRecipesDataModel {
    let recipeId : Int
    let recipeImage : String?
    let recipeRating : String?
    let cookDuration : String?
    let recipeTitle : String?
    let authorAvatar : String?
    let authorName : String?
    let isSavedToFavorite : Bool?
    let categoryName : String
}
