import FluentSQLite
import Vapor

final class Meal: Codable {
    var id: UUID?
    var name: String
    var price: Int
    
    init(name: String, price: Int) {
        self.name = name
        self.price = price
    }
}

extension Meal: SQLiteUUIDModel {}
extension Meal: Content {}
extension Meal: Migration {}
extension Meal: Parameter {}
