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
    var creationDate: Date
    
    //modificationDate
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    //la relacion con addresses
    @Siblings(through: AddressToCustomer.self, from: \.$customerId, to: \.$addressId)
    var addresses: [Address]
    
    
    //la relacion con contacto
    
    @Siblings(through: ContactInfoToCustomer.self, from: \.$customerId, to: \.$contactInfoId)
    var contactInfo: [ContactInfo]
    
    
    // PENDIENTE: crear la relacion con paymentmethod
   
    @Parent(key: "company_id")
    var company: Company
    
    @Children(for: \.$customer)
    var paymentTerms: [paymentTerms]
    
    // Creates a new, empty Address.
    init() { }
    
    init(id: UUID?, name: String, vat: String , company_id: Company.IDValue) {
        self.id = id
        self.name = name
        self.vat = vat
        self.$company.id = company_id
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}


