import Foundation
import Fluent

final class Customer: Model {
    // Name of the table or collection.
    static let schema = "customer"

    // Unique identifier for this customer.
    @ID(key: .id)
    var id: UUID?

    //Customer Name
    @Field(key: "name")
    var name: String
    
    //VAT number
    @Field(key: "vat")
    var vat: String
    
    //creationDate
    @Field(key: "creationDate")
    var creationDate: String
    
    //modificationDate
    @Field(key: "modificationDate")
    var modificationDate: String
    
    // PENDIENTE: crear la relacion con addresses
    // PENDIENTE: crear la relacion con contacto
    // PENDIENTE: crear la relacion con paymentmethod
    //@Siblings(through: addressToCompany.self, from: \.$addressId, to: \.$companyId)
    //var companyId: [Company]
    
    
    // Creates a new, empty Address.
    init() { }

    init(id: UUID?, name: String, vat: String) {
        self.id = id
        self.name = name
        self.vat = vat
        self.creationDate = "01/01/2020"
        self.modificationDate = "01/01/2020"
    }
}


