import Foundation
import Fluent

final class TaxTypeToProducts: Model {
    // Name of the table or collection.
    static let schema = "TaxTypeToProducts"

    // Unique identifier for this TaxTypeToProducts.
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "taxTypeId")
     var taxTypeId: taxType
    
    @Parent(key: "productsId")
    var productsId: Product
    
    // Creates a new, empty TaxTypeToProducts.
    init() { }

    init(taxTypeId: UUID?, productsId: UUID?) {
        self.$taxTypeId.id = taxTypeId!
        self.$productsId.id = productsId!
    }
}
