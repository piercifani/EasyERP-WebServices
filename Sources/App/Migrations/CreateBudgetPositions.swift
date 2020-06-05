import Foundation
import Fluent

struct CreateBudgetPositions: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("budgetPositions")
            .id()
            .field("internalID", .int)
            .field("quantityRequested", .int)
            .field("quantitySold", .string)
            .field("quantityStockout", .string)
            .field("netPricePerUnit", .string)
            .field("vatPerUnit", .string)
            .field("totalVatPerProduct", .string)
            .field("totalGrossPricePerProduct", .string)
            .field("costPerUnit", .string)
            .field("totalCostPerProduct", .string)
            .field("modificationDate", .date)
            .field("creationDate", .date)
            .field("headerBudget_id", .uuid, .references("budgetHeader", "id"))
            .field("product_id", .uuid, .references("product", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("budgetPositions").delete()
    }
}
