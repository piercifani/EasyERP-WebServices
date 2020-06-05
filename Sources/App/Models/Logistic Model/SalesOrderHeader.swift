import Foundation
import Fluent

final class SalesOrderHeader: Model {
    // Name of the table or collection.
    static let schema = "salesOrderHeader"
    
    // Unique identifier for this salesOrder.
    @ID(key: .id)
    var id: UUID?
    
    
    //SNAPSHOT CUSTOMER
    
    //Customer ID
    @Field(key: "customerId")
    var customerId: UUID
    
    //Customer Name
    @Field(key: "customerName")
    var customerName: String
    
    //VAT number
    @Field(key: "customerVatNumber")
    var customerVatNumber: String
    
    //SNAPSHOT CONTACT INFO
    
    // Name
    @Field(key: "contactInfoName")
    var contactInfoName: String
    
    // LasteName
    @Field(key: "contactInfoLastName")
    var contactInfoLastName: String
    
    // Phone1
    @Field(key: "contactInfoPhone1")
    var contactInfoPhone1: String
    
    // Phone2
    @Field(key: "contactInfoPhone2")
    var contactInfoPhone2: String
    
    // email1
    @Field(key: "contactInfoEmail1")
    var contactInfoEmail1: String
    
    // email2
    @Field(key: "contactInfoEmail2")
    var contactInfoEmail2: String
    
    //UNIQUE DELIVERY ADDRESS FOR THE SALES ORDER
    
    // Delivery Address1
    @Field(key: "deliveryAddress1")
    var deliveryAddress1: String
    
    // Delivery Address2
    @Field(key: "deliveryAddress2")
    var deliveryAddress2: String
    
    // Delivery ZipCode
    @Field(key: "deliveryZipCode")
    var deliveryZipCode: String
    
    // Delivery City
    @Field(key: "deliveryCity")
    var deliveryCity: String
    
    // Delivery zoneCode
    @Field(key: "deliveryZoneCode")
    var deliveryZoneCode: String
    
    // Delivery CountryCode
    @Field(key: "deliveryCountryCode")
    var deliveryCountryCode: String
    
    //UNIQUE BILLING ADDRESS FOR THE SALES ORDER
    
    // billing Address1
    @Field(key: "billingAddress1")
    var billingAddress1: String
    
    // billing Address2
    @Field(key: "billingAddress2")
    var billingAddress2: String
    
    // billing ZipCode
    @Field(key: "billingZipCode")
    var billingZipCode: String
    
    // billing City
    @Field(key: "billingCity")
    var billingCity: String
    
    // billing zoneCode
    @Field(key: "billingZoneCode")
    var billingZoneCode: String
    
    // billing CountryCode
    @Field(key: "billingCountryCode")
    var billingCountryCode: String
    
    //-----------------------------
    
    //Creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    //Modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    @Parent(key: "company_id")
    var company: Company
    
    @Children(for: \.$salesOrderHeader)
    var salesOrderPositions: [SalesOrderPositions]
    
    @Children(for: \.$salesOrderHeader)
    var deliveryHeader: [DeliveryHeader]
    
    // Creates a new, empty sales order
    init() { }
    
    init(id: UUID? , company_id: Company.IDValue , customerId: UUID,customerName : String, customerVatNumber : String, contactInfoName: String, contactInfoLastName : String, contactInfoPhone1 : String, contactInfoPhone2 : String, contactInfoEmail1 : String , contactInfoEmail2 : String, deliveryAddress1 : String , deliveryAddress2 : String , deliveryZipCode : String , deliveryCity : String , deliveryZoneCode : String , deliveryCountryCode : String , billingAddress1 : String , billingAddress2 : String , billingZipCode : String ,  billingCity : String , billingZoneCode : String , billingCountryCode :String ) {
        
        
        self.id = id
        self.$company.id = company_id
        
        self.customerId = customerId
        self.customerName = customerName
        self.customerVatNumber = customerVatNumber
        
        self.contactInfoName = contactInfoName
        self.contactInfoLastName = contactInfoLastName
        self.contactInfoPhone1 = contactInfoPhone1
        self.contactInfoPhone2 = contactInfoPhone2
        self.contactInfoEmail1 = contactInfoEmail1
        self.contactInfoEmail2 = contactInfoEmail2
        
        self.deliveryAddress1 = deliveryAddress1
        self.deliveryAddress2 = deliveryAddress2
        self.deliveryZipCode = deliveryZipCode
        self.deliveryCity = deliveryCity
        self.deliveryZoneCode = deliveryZoneCode
        self.deliveryCountryCode = deliveryCountryCode
        
        self.billingAddress1 = billingAddress1
        self.billingAddress2 = billingAddress2
        self.billingZipCode = billingZipCode
        self.billingCity = billingCity
        self.billingZoneCode = billingZoneCode
        self.billingCountryCode = billingCountryCode
        
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}
