import Foundation
import Fluent

final class ProductsToBudgetPositions: Model {
    // Name of the table or collection.
    static let schema = "ProductsToBudgetPositions"

    // Unique identifier for this TaxTypeToProducts.
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "productsId")
     var productId: Product
    
    @Parent(key: "budgetPositionsId")
    var budgetPositionsId: BudgetPositions
    
    // Creates a new, empty TaxTypeToProducts.
    init() { }

    init(productsId: UUID?, budgetPositionsId: UUID?) {
        self.$productId.id = productsId!
        self.$budgetPositionsId.id = budgetPositionsId!
    }
}
