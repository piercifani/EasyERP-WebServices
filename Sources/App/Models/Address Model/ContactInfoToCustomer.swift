import Foundation
import Fluent

final class ContactInfoToCustomer: Model {
    // Name of the table or collection.
    static let schema = "ContactInfoToCustomer"

    // Unique identifier for this ContactInfoToCustomer.
    @ID(key: .id)
    var id: UUID?

    @Parent(key: "contactInfoId")
     var contactInfoId: ContactInfo
    
    @Parent(key: "customerId")
    var customerId: Customer
    
    // Creates a new, empty addressToObject.
    init() { }

    init(contactInfoId: UUID?, customerId: UUID?) {
        self.$contactInfoId.id = contactInfoId!
        self.$customerId.id = customerId!
    }
}
