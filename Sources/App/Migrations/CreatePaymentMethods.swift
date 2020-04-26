import Foundation
import Fluent

struct CreatePaymentMethods: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("paymentMethods")
            .id()
            .field("description", .string)
            .field("dueDate", .string)
            .field("rate", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("paymentMethods").delete()
    }
}
