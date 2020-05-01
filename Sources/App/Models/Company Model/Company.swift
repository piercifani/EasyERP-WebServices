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
    
    // The Company VAT number.
    @Field(key: "companyVatNumber")
    var companyVatNumber: String
    
    // Creation Date.
    @Field(key: "creationDate")
    var creationDate: Date
    
    // mainCurrency
    @Field(key: "mainCurrency")
    var mainCurrency: String
    
    // mainLanguage
    @Field(key: "mainLanguage")
    var mainLanguage: String
    
    @Siblings(through: AddressToCompany.self, from: \.$companyId, to: \.$addressId)
    var companyAddresID: [Address]
    
    @Children(for: \.$company)
    var products: [Product]

    // Creates a new, empty Company.
    init() { }
    
    init(id: UUID?, name: String, companyVatNumber: String, mainCurrency: String, mainLanguage: String) {
        self.id = id
        self.name = name
        self.companyVatNumber = companyVatNumber
        self.creationDate = Date()
        self.mainCurrency = mainCurrency
        self.mainLanguage = mainLanguage
    }
}


