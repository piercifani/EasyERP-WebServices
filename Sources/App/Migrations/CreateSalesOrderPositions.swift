import Foundation
import Fluent

struct CreateSalesOrderPositions: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("salesOrderPositions")
            .id()
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("salesOrderHeader_id", .uuid, .references("salesOrderHeader", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("salesOrderPositions").delete()
    }
}
