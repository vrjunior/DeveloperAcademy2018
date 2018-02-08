import Foundation

public struct Ingredients:Codable{
    var ingredients:[Ingredient]
    
    
    /// Creates a set of ingredients based on the playground JSON file
    ///
    /// - Returns: Dictionary containing the combination Ingredient Id x Ingredient
    static func setupIngredients() -> [Int:Ingredient] {
        
        let ingredientFile = Bundle.main.url(forResource: "ingredients", withExtension: "json")
        let jsonString = try! String(contentsOf: ingredientFile!, encoding: String.Encoding.utf8)
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()

        let ingredients = try! decoder.decode(Ingredients.self, from: jsonData)
        
        //Map the dictionary Ingredient Id x Ingredient
        let ingredientDictionary = ingredients.ingredients.reduce([Int:Ingredient]()) { (partial, ingredient) -> [Int:Ingredient] in
            let newIngredient:[Int:Ingredient] = [ingredient.id:ingredient]
            return partial.merging(newIngredient, uniquingKeysWith: {(old, new) -> Ingredient in
                return new
            })
        }
        
        return ingredientDictionary
    }
}

public struct Ingredient:Hashable, Codable, CustomStringConvertible {
    public var name:String
    public var id:Int
    
    enum CodingKey:String, Swift.CodingKey {
        case id = "id"
        case name = "name"
    }
    
    public var hashValue:Int {
        get {return id}
    }
    
    public static func == (lhs:Ingredient, rhs:Ingredient) -> Bool {
       return lhs.id == rhs.id
    }
    
    public var description:String {
        get {
            return name
        }
    }
    
}



