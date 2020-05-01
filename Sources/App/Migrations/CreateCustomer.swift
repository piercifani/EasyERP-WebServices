import Foundation
import Fluent

struct CreateCustomer: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("customer")
            .id()
            .field("name", .string)
            .field("vat", .string)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("customer").delete()
    }
}
