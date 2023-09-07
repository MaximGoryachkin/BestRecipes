import Foundation

struct UsersDataModel {
    var userName : String
    var email : String
    var password : String
    var userAvatarLocalPath : String?
    var usersRecipes : [RecipeDataModel]?
}
