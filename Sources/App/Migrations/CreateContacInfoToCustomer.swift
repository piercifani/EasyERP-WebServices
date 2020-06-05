import Foundation
import Fluent

struct CreateContactInfoToCustomer: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("contactInfoToCustomer")
            .id()
            .field("contactInfoId", .string)
            .field("customerId", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("contactInfoToCustomer").delete()
    }
}
