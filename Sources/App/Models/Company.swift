import Foundation
import Fluent

final class Company: Model {
    // Name of the table or collection.
    static let schema = "company"

    // Unique identifier for this Company.
    @ID(key: .id)
    var id: UUID?

    // The Company's name.
    @Field(key: "name")
    var name: String

    @Children(for: \.$company)
    var products: [Product]

    init() { }

    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}


