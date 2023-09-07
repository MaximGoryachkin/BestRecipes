import UIKit.UIImage

struct AuthorsModel {
    let name : String
    let avatar : UIImage
}

extension AuthorsModel {
    static var popularCreators : [AuthorsModel] = [
        .init(name: "Foodista", avatar: UIImage(named: "Foodista")!),
        .init(name: "foodista.com", avatar: UIImage(named: "foodista.com")!),
        .init(name: "Afrolems", avatar: UIImage(named: "Afrolems")!),
        .init(name: "Full Belly Sisters", avatar: UIImage(named: "Full_Belly_Sisters")!),
        .init(name: "Pink When", avatar: UIImage(named: "pinkwhen")!)
    ]
    
    static func loadAllPopulars() {
        self.popularCreators += [
            .init(name: "afrolems.com", avatar: UIImage(named: "Afrolems")!),
            .init(name: "blogspot.com", avatar: UIImage(named: "blogspot.com")!),
            .init(name: "Food and Spice", avatar: UIImage(named: "Food and Spice")!),
            .init(name: "pinkwhen.com", avatar: UIImage(named: "pinkwhen")!)
        ]
    }
}
