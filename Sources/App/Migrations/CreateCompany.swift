import Foundation
import Fluent

struct CreateCompany: Migration {
    // Prepares the database for storing Galaxy models.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("company")
            .id()
            .field("name", .string)
            .field("companyVatNumber", .string)
            .field("companyAddressId", .string)
            .field("creationDate", .string)
            .field("mainCurrency", .string)
            .field("mainLanguage", .string)
            .create()
    }

    // Optionally reverts the changes made in the prepare method.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("company").delete()
    }
}

