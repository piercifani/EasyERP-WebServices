import Foundation
import Fluent

struct CreatePaymentMethod: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("paymentMethod")
            .id()
            .field("description", .string)
            .field("dueDate", .string)
            .field("rate", .string)
            .field("customer_id", .uuid, .references("customer", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("paymentMethod").delete()
    }
}
