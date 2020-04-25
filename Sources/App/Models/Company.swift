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

    // Creates a new, empty Galaxy.
    init() { }

    init(id: UUID?, name: String) {
        self.id = id
        self.name = name
    }
}


