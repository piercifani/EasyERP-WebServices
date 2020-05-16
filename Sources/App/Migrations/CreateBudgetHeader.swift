import Foundation
import Fluent

struct CreateBudgetHeader: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("budgetHeader")
            .id()
            .field("name", .string)
            .field("expectedDate", .date)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("totalGrossAmount", .string)
            .field("totalNetAmount", .string)
            .field("totalQty", .string)
            .field("globalStatus", .string)
            .field("company_id", .uuid, .references("company", "id"))
            .field("customer_id", .uuid, .references("customer", "id"))
            .field("delivery_address_id", .uuid, .references("address", "id"))
            .field("billing_address_id", .uuid, .references("address", "id"))
            .field("contactInfo_id", .uuid, .references("contactInfo", "id"))
            .field("paymentTerms_id", .uuid, .references("paymentTerms", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("budgetHeader").delete()
    }
}
