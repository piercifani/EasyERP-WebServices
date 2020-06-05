import Foundation
import Fluent

struct CreateSalesOrderHeader: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("salesOrderHeader")
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

            
            .field("billingAddress1", .string)
            .field("billingAddress2", .string)
            .field("billingZipCode", .string)
            .field("billingCity", .string)
            .field("billingZoneCode", .string)
            .field("billingCountryCode", .string)
            
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .field("company_id", .uuid, .references("company", "id"))
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("salesOrderHeader").delete()
    }
}


