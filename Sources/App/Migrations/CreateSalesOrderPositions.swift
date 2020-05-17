import Foundation
import Fluent

struct CreateSalesOrderPositions: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("salesOrderPositions")
            .id()
            .field("budgetHeaderId", .uuid)
            .field("internalID", .uuid)
            .field("productName", .string)
            .field("EAN", .string)
            .field("dimX", .string)
            .field("dimY", .string)
            .field("dimZ", .string)
            .field("weight", .string)
            .field("measureUnit", .string)
            .field("quantityRequested", .string)
            .field("quantitySold", .string)
            .field("quantityStockout", .string)
            .field("netPricePerUnit", .string)
            .field("vatPerUnit", .string)
            .field("photoURL", .string)
            .field("costPerUnit", .string)
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
