import Foundation
import Fluent

final class Address: Model {
    // Name of the table or collection.
    static let schema = "address"

    // Unique identifier for this Address.
    @ID(key: .id)
    var id: UUID?

    // Address1
    @Field(key: "address1")
    var address1: String
    
    // Address2
       @Field(key: "address2")
       var address2: String

    // ZipCode
    @Field(key: "zipCode")
    var zipCode: String
    
    // City
    @Field(key: "city")
    var city: String
    
    // zoneCode
    @Field(key: "zoneCode")
    var zoneCode: String
    
    // CountryCode
    @Field(key: "countryCode")
    var contryCode: String
    
    @Siblings(through: addressToCompany.self, from: \.$addressId, to: \.$companyId)
    var companyId: [Company]
    
    
    // Creates a new, empty Address.
    init() { }

    init(id: UUID?, address1: String, address2: String, zipCode:String, city: String, zoneCode: String, countryCode: String) {
        self.id = id
        self.address1 = address1
        self.address2 = address2
        self.zipCode = zipCode
        self.city = city
        self.zoneCode = zoneCode
        self.contryCode = countryCode
    }
}

