import Foundation
import Fluent

struct CreateProduct: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product")
            .id()
            .field("name", .string)
            .field("company_id", .uuid, .references("company", "id"))
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("product").delete()
    }
}
