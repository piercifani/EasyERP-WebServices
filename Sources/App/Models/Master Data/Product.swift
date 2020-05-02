import Foundation
import Fluent

final class Product: Model {
    // Name of the table or collection.
    static let schema = "product"
    
    // Unique identifier for this product.
    @ID(key: .id)
    var id: UUID?
    
    // product name.
    @Field(key: "name")
    var name: String
    
    // product type.
    @Field(key: "productType")
    var productType: String
    
    // supplier reference id.
    @Field(key: "supplierReferenceId")
    var supplierReferenceId: String
    
    // EAN code
    @Field(key: "EAN")
    var EAN: String
    
    // Long Description
    @Field(key: "LongDesc")
    var LongDesc: String
    
    // photoURL
    @Field(key: "photoURL")
    var photoURL: String
    
    // dimensionX
    @Field(key: "dimX")
    var dimX: String
    
    // dimensionY
    @Field(key: "dimY")
    var dimY: String
    
    // dimensionZ
    @Field(key: "dimZ")
    var dimZ: String
    
    // weight
    @Field(key: "weight")
    var weight: String
    
    // measure Unit (KG, Lt, UN, ...)
    @Field(key: "measureUnit")
    var measureUnit: String
    
    // creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    // modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    @Parent(key: "company_id")
    var company: Company
    
    @Siblings(through: TaxTypeToProducts.self, from: \.$productsId, to: \.$taxTypeId)
    var taxType: [taxType]
    
    // Creates a new, empty Galaxy.
    init() { }
    
    init(id: UUID?, name: String, productType: String, supplierReferenceId: String, EAN: String, LongDesc: String, photoURL: String , dimX: String, dimY: String, dimZ: String, weight: String, measureUnit: String, company_id: Company.IDValue) {
        self.id = id
        self.name = name
        self.productType = productType
        self.supplierReferenceId = supplierReferenceId
        self.EAN = EAN
        self.LongDesc = LongDesc
        self.photoURL = photoURL
        self.dimX = dimX
        self.dimY = dimY
        self.dimZ = dimZ
        self.weight = weight
        self.measureUnit = measureUnit
        self.creationDate = Date()
        self.modificationDate = Date()
        self.$company.id = company_id
    }
}


  
