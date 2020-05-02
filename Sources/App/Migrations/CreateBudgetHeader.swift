import Foundation
import Fluent

struct CreateBudgetHeader: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("createBudgetHeader")
            .id()
            .field("name", .string)
            .field("vat", .string)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("company_id", .uuid, .references("company", "id"))
            .field("customer_id", .uuid, .references("customer", "id"))
            .field("delivery_address_id", .uuid, .references("address", "id"))
            .field("billing_address_id", .uuid, .references("address", "id"))
            .field("contactInfo_id", .uuid, .references("contacInfo", "id"))
            .field("paymentTerms_id", .uuid, .references("paymentTerms", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("createBudgetHeader").delete()
    }
}
