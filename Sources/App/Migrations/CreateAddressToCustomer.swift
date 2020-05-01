import Foundation
import Fluent

struct CreateAddressToCustomer: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("addressToCustomer")
            .id()
            .field("addressId", .string)
            .field("customerId", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("addressToCustomer").delete()
    }
}
