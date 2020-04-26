import Foundation
import Fluent

struct CreateAddress: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("address")
            .id()
            .field("address1", .string)
            .field("address2", .string)
            .field("zipCode", .string)
            .field("city", .string)
            .field("zoneCode", .string)
            .field("countryCode", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("address").delete()
    }
}
