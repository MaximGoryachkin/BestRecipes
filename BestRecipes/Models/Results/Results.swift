
struct Results: Codable {
    let results: [Result]
    let totalResults : Int
}

struct Result: Codable {
    let id: Int
    let sourceName: String?
    let title: String
    let readyInMinutes: Int?
    let image: String
    let summary: String?
    let analyzedInstructions: [Instruction]
    let extendedIngredients: [Ingredient]
    let veryPopular: Bool?
}
    
