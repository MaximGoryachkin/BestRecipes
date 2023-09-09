
import Foundation

struct CreateRecipeSettingDataModel {
    let iconImageName : String
    let titleText : String
}

extension CreateRecipeSettingDataModel {
    static let prebuildData : [CreateRecipeSettingDataModel] = [
        .init(iconImageName: "Icons/Profile", titleText: "Serves"),
        .init(iconImageName: "Icons/Clock", titleText: "Cook time")
    ]
}
