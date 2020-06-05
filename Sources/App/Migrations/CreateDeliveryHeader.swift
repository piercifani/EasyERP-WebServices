import Foundation
import Fluent

struct CreateDeliveryHeader: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("deliveryHeader")
            .id()
            
        
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
            
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("company_id", .uuid, .references("company", "id"))
            .field("salesOrderHeader_id", .uuid, .references("salesOrderHeader", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("deliveryHeader").delete()
    }
}


