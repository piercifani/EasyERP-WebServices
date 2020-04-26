import Foundation
import Fluent

final class Product: Model {
    
    // Name of the table or collection.
    static let schema = "products"

    // Unique identifier for this Company.
    @ID(key: .id)
    var id: UUID?

    // The Company's name.
    @Field(key: "name")
    var name: String

    @Parent(key: "company_id")
    var company: Company
    
    init() { }

    init(id: UUID? = nil, name: String, company_id: Company.IDValue) {
        self.id = id
        self.name = name
        self.$company.id = company_id
    }
}
