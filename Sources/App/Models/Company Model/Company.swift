import Foundation
import Fluent

final class Company: Model {
    // Name of the table or collection.
    static let schema = "company"

    // Unique identifier for this Company.
    @ID(key: .id)
    var id: UUID?

    // The Company's name.
    @Field(key: "name")
    var name: String

   // companyAddressID
    @Field(key: "companyAddressId")
    var companyAddressId: UUID?
    
    // The Company VAT number.
    @Field(key: "companyVatNumber")
    var companyVatNumber: String
    
    // Creation Date.
    @Field(key: "creationDate")
    var creationDate: NSDate
    
    // mainCurrency
    @Field(key: "mainCurrency")
    var mainCurrency: String
    
    // mainLanguage
       @Field(key: "mainLanguage")
       var mainLanguage: String
    
    // Creates a new, empty Company.
    init() { }

    init(id: UUID?, name: String ,companyVatNumber: String, mainCurrency: String, mainLanguage: String) {
        self.id = id
        self.name = name
        self.companyVatNumber = companyVatNumber
        self.companyAddressId = UUID()
        self.creationDate = NSDate()
        self.mainCurrency = mainCurrency
        self.mainLanguage = mainLanguage
    }
}


