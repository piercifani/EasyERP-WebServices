import Foundation
import Fluent

struct CreateDeliveryPositions: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("deliveryPositions")
            .id()
            .field("budgetHeaderId", .uuid)
            .field("salesOrderPositionId", .uuid)
            .field("salesOrderPositionInternalId", .uuid)
            .field("salesOrderHeaderId", .uuid)
            .field("internalID", .int)
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
            .field("expectedDeliveryDate", .date)
            .field("realDeliveryDate", .date)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("deliveryHeader_id", .uuid, .references("deliveryHeader", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("deliveryPositions").delete()
    }
}