import Foundation
import Fluent

final class AddressToCompany: Model {
    // Name of the table or collection.
    static let schema = "addressToCompany"

    // Unique identifier for this addressToCompany.
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "addressId")
     var addressId: Address
    
    @Parent(key: "companyId")
    var companyId: Company
    
    // Creates a new, empty addressToObject.
    init() { }

    init(addressId: UUID?, companyId: UUID?) {
        self.$addressId.id = addressId!
        self.$companyId.id = companyId!
    }
}
