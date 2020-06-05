import Foundation
import Fluent

struct CreateTaxType: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("taxType")
            .id()
            .field("description", .string)
            .field("country", .string)
            .field("region", .string)
            .field("rate", .string)
            .field("company_id", .uuid, .references("company", "id"))
            
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("taxType").delete()
    }
}
