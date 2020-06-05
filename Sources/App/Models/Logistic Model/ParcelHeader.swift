import Foundation
import Fluent

final class ParcelHeader: Model {
    // Name of the table or collection.
    static let schema = "parcelHeader"
    
    // Unique identifier for this delivery.
    @ID(key: .id)
    var id: UUID?
    
    
    //PARCEL SPECIFIC
    
    //tracking number
    @Field(key: "trackingNumber")
    var trackingNumber: String
    
    //parcel status
    @Field(key: "parcelStatus")
    var parcelStatus: String
    
    //carrierName
    @Field(key: "carrierName")
    var carrierName: String
    
    //carrierService
    @Field(key: "carrierService")
    var carrierService: String
    
    
    
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
    
    
    //Creation Date
    @Field(key: "expectedDeliveryDate")
    var expectedDeliveryDate: Date
    
    //Creation Date
    @Field(key: "realDeliveryDate")
    var realDeliveryDate: Date
    
    
    //Creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    //Modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    @Parent(key: "company_id")
    var company: Company
    
    @Parent(key: "deliveryHeader_id")
    var deliveryHeader: DeliveryHeader
    
    @Children(for: \.$parcelHeader)
    var parcelPostions: [ParcelPositions]
    
    // Creates a new, empty sales order
    init() { }
    
    init(id: UUID? , company_id: Company.IDValue , deliveryHeader_id : DeliveryHeader.IDValue, customerId: UUID,customerName : String, customerVatNumber : String, contactInfoName: String, contactInfoLastName : String, contactInfoPhone1 : String, contactInfoPhone2 : String, contactInfoEmail1 : String , contactInfoEmail2 : String, deliveryAddress1 : String , deliveryAddress2 : String , deliveryZipCode : String , deliveryCity : String , deliveryZoneCode : String , deliveryCountryCode : String , trackingNumber : String , parcelStatus : String , carrierName : String , carrierService : String , expectedDeliveryDate : Date) {
        
        
        self.id = id
        self.$company.id = company_id
        self.$deliveryHeader.id = deliveryHeader_id
        
        self.trackingNumber = trackingNumber
        self.parcelStatus = parcelStatus
        self.carrierName = carrierName
        self.carrierService = carrierService
        
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
        
        
        self.expectedDeliveryDate = expectedDeliveryDate
        self.realDeliveryDate = Date()
        
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}
