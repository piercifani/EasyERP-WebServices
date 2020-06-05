import Foundation
import Fluent

struct CreateTaxTypeToProducts: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("TaxTypeToProducts")
            .id()
            .field("taxTypeId", .string)
            .field("productsId", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("TaxTypeToProducts").delete()
    }
}
