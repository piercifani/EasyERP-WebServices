import Foundation
import Fluent

final class AddressToCustomer: Model {
    // Name of the table or collection.
    static let schema = "addressToCustomer"

    // Unique identifier for this addressToCustomer.
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "addressId")
     var addressId: Address
    
    @Parent(key: "customerId")
    var customerId: Customer
    
    // Creates a new, empty addressToObject.
    init() { }

    init(addressId: UUID?, customerId: UUID?) {
        self.$addressId.id = addressId!
        self.$customerId.id = customerId!
    }
}

