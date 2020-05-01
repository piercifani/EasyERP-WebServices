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
    var dueDate: Date
    
    // percentage of the amount (>0% to 100%)
    @Field(key: "rate")
    var rate: String
    
    
    //PENDINTE: crear la relacion con customer y vendors
    
    //@Siblings(through: addressToCompany.self, from: \.$addressId, to: \.$companyId)
    //var companyId: [Company]
    
    
    // Creates a new, empty PaymentMethod.
    init() { }
    
    init(id: UUID?, description: String, dueDate: Date, rate:String) {
        self.id = id
        self.description = description
        self.dueDate = dueDate
        self.rate = rate
    }
}


