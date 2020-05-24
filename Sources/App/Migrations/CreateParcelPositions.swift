import Foundation
import Fluent

struct CreateParcelPositions: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ParcelPositions")
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
            .field("photoURL", .string)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("parcelHeader_id", .uuid, .references("parcelHeader", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("parcelPositions").delete()
    }
}
