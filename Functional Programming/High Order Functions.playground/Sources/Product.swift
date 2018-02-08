import Foundation

public struct Products:Codable{
    var products:[Product]
    
    
    /// Get a list of products for testing based on the Playground JSON file
    ///
    /// - Returns: Sample list of products
    public static func setupProducts() -> [Product] {
        
        let ingredients = Ingredients.setupIngredients()
        
        
        let productFile = Bundle.main.url(forResource: "products", withExtension: "json")
        let jsonString = try! String(contentsOf: productFile!, encoding: String.Encoding.utf8)
        
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let products = try! decoder.decode(Products.self, from: jsonData)
        
        let productList = products.products.map { (product) -> Product in
            var updatedProduct = product
            let ingredientList = product.ingredientIndexes.map { (index) -> Ingredient in
                ingredients[index]!
            }
            updatedProduct.ingredients = ingredientList
            return updatedProduct
        }
        
       return productList
    
    }
}

public struct Product:Hashable, Codable, CustomStringConvertible {
    public var name:String
    public var id:Int
    public var ingredientIndexes:[Int]
    public var ingredients:[Ingredient]?
    
    private enum CodingKeys:String, Swift.CodingKey {
        case name = "name"
        case id = "id"
        case ingredientIndexes = "ingredients"
    }
    
    public var hashValue:Int {
        get {return id}
    }
    
    public static func == (lhs:Product, rhs:Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        var ingredientArray = try container.nestedUnkeyedContainer(forKey: .ingredientIndexes)
        
        var indexes: [Int] = []
        while (!ingredientArray.isAtEnd) {
            let ingredientIndex = try ingredientArray.decode(Int.self)
            indexes.append(ingredientIndex)
        }
        
        self.name = name
        self.id = id
        self.ingredientIndexes = indexes
        
    }

    public var description:String {
        get {
            return name
        }
    }
    
}

