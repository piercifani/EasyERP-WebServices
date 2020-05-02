import Foundation
import Fluent

final class paymentMethod: Model {
    // Name of the table or collection.
    static let schema = "paymentMethod"
    
    // Unique identifier for this Address.
    @ID(key: .id)
    var id: UUID?
    
    // description
    @Field(key: "description")
    var description: String
    
    // days to execute the event (0 days to XX days)
    @Field(key: "dueDate")
    var dueDate: String
    
    // percentage of the amount (>0% to 100%)
    @Field(key: "rate")
    var rate: String
    
    
    //PENDINTE: crear la relacion con customer y vendors
    
    @Parent(key: "customer_id")
    var customer: Customer
    
    
    // Creates a new, empty PaymentMethod.
    init() { }
    
    init(id: UUID?, description: String, dueDate: String, rate:String , customerID: Customer.IDValue) {
        self.id = id
        self.description = description
        self.dueDate = dueDate
        self.rate = rate
        self.$customer.id = customerID
    }
}


