import Foundation
import Fluent

final class ContactInfo: Model {
    // Name of the table or collection.
    static let schema = "contactInfo"
    
    // Unique identifier for this contactInfo.
    @ID(key: .id)
    var id: UUID?
    
    // Name
    @Field(key: "Name")
    var name: String
    
    // LasteName
    @Field(key: "lastName")
    var lastName: String
    
    // Phone1
    @Field(key: "Phone1")
    var phone1: String
    
    // Phone2
    @Field(key: "Phone2")
    var phone2: String
    
    // email1
    @Field(key: "email1")
    var email1: String
    
    // email2
    @Field(key: "email2")
    var email2: String
    
    // website
    @Field(key: "website")
    var website: String
    
    // creationDate
    @Field(key: "creationDate")
    var creationDate: Date
    
    // modificationDate
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    
    //relacion con customer
     @Siblings(through: ContactInfoToCustomer.self, from: \.$contactInfoId, to: \.$customerId)
       var customerId: [Customer]
    
    
    // Creates a new, empty Address.
    init() { }
    
    init(id: UUID?, name: String, lastName: String, email1: String, email2:String, phone1: String, phone2: String, website: String) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.email1 = email1
        self.email2 = email2
        self.phone1 = phone1
        self.phone2 = phone2
        self.website = website
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}

