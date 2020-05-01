import Foundation
import Fluent

final class taxType: Model {
    // Name of the table or collection.
    static let schema = "taxType"
    
    // Unique identifier for this taxType.
    @ID(key: .id)
    var id: UUID?
    
    // description
    @Field(key: "description")
    var description: String
    
    // country
    @Field(key: "country")
    var country: String
    
    // country
    @Field(key: "region")
    var region: String
    
    // percentage of the amount (>0% to 100%)
    @Field(key: "rate")
    var rate: String
    
    
    //PENDINTE: crear la relacion con productos
    
    //@Siblings(through: addressToCompany.self, from: \.$addressId, to: \.$companyId)
    //var companyId: [Company]
    
    
    // Creates a new, empty taxType.
    init() { }
    
    init(id: UUID?, description: String, country: String, region: String, rate:String) {
        self.id = id
        self.description = description
        self.country = country
        self.region = region
        self.rate = rate
    }
}

