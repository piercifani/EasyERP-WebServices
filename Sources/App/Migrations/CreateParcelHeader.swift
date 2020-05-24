import Foundation
import Fluent

struct CreateParcelHeader: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("parcelHeader")
            .id()
            
            .field("trackingNumber", .string)
            .field("parcelStatus", .string)
            .field("carrierName", .string)
            .field("carrierService", .string)
        
            .field("customerId", .uuid)
            .field("customerName", .string)
            .field("customerVatNumber", .string)

            .field("contactInfoName", .string)
            .field("contactInfoLastName", .string)
            .field("contactInfoPhone1", .string)
            .field("contactInfoPhone2", .string)
            .field("contactInfoEmail1", .string)
            .field("contactInfoEmail2", .string)
            
            .field("deliveryAddress1", .string)
            .field("deliveryAddress2", .string)
            .field("deliveryZipCode", .string)
            .field("deliveryCity", .string)
            .field("deliveryZoneCode", .string)
            .field("deliveryCountryCode", .string)
            
            
            .field("expectedDeliveryDate", .date)
            .field("realDeliveryDate", .date)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("company_id", .uuid, .references("company", "id"))
            .field("deliveryHeader_id", .uuid, .references("deliveryHeader", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("parcelHeader").delete()
    }
}


   
