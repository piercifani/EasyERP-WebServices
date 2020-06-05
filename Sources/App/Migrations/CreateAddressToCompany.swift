import Foundation
import Fluent

struct CreateAddressToCompany: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("addressToCompany")
            .id()
            .field("addressId", .string)
            .field("companyId", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("addressToCompany").delete()
    }
}
