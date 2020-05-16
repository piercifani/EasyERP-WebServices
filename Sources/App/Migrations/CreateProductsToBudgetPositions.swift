import Foundation
import Fluent

struct CreateProductsToBudgetPositions: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ProductsToBudgetPositions")
            .id()
            .field("productsId", .string)
            .field("budgetPositionsId", .string)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("ProductsToBudgetPositions").delete()
    }
}
