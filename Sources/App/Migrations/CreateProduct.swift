import Foundation
import Fluent

struct CreateProduct: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product")
            .id()
            .field("name", .string)
            .field("productType", .string)
            .field("supplierReferenceId", .string)
            .field("EAN", .string)
            .field("LongDesc", .string)
            .field("photoURL", .string)
            .field("dimX", .string)
            .field("dimY", .string)
            .field("dimZ", .string)
            .field("weight", .string)
            .field("measureUnit", .string)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("company_id", .uuid, .references("company", "id"))
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product").delete()
    }
}

