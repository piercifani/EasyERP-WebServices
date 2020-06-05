import Foundation
import Fluent

struct CreateContactInfo: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("contactInfo")
            .id()
            .field("name", .string)
            .field("lastName", .string)
            .field("email1", .string)
            .field("email2", .string)
            .field("phone1", .string)
            .field("phone2", .string)
            .field("website", .string)
            .field("creationDate", .date)
            .field("modificationDate", .date)
            .create()
    }
    
    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("contactInfo").delete()
    }
}
