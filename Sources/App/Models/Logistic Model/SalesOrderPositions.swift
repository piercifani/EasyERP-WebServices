import Foundation
import Fluent

final class SalesOrderPositions: Model {
    // Name of the table or collection.
    static let schema = "SalesOrderPositions"
    
    // Unique identifier for this salesOrder.
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "salesOrderHeader_id")
    var salesOrderHeader: SalesOrderHeader
    
    // budgetHeaderID
    @Field(key: "budgetHeaderId")
    var budgetHeaderId: UUID
    
    // product name.
    @Field(key: "productName")
    var productName: String
    
    // EAN code
    @Field(key: "EAN")
    var EAN: String
    
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
    
    @Field(key: "quantityRequested")
    var quantityRequested: String
    
    @Field(key: "quantitySold")
    var quantitySold: String
    
    @Field(key: "quantityStockout")
    var quantityStockout: String
    
    @Field(key: "netPricePerUnit")
    var netPricePerUnit: String
    
    @Field(key: "vatPerUnit")
    var vatPerUnit: String
    
    @Field(key: "costPerUnit")
    var costPerUnit: String
    
    //Creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    //Modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    
    //PENDIENTE: deliveryOrder
    
    //PARCEL
    
    //INVOICE
    
    
    
    // Creates a new, empty sales order
    init() { }
    
    init(id: UUID? , salesOrderHeader_id: SalesOrderHeader.IDValue, budgetHeaderId: UUID, productName : String, EAN : String, photoURL : String , dimX : String , dimY: String, dimZ : String , weight : String, measureUnit : String , netPricePerUnit : String , vatPerUnit : String , costPerUnit : String) {
        self.id = id
        self.$salesOrderHeader.id = salesOrderHeader_id
        self.budgetHeaderId = budgetHeaderId
        self.productName = productName
        self.EAN = EAN
        self.photoURL = photoURL
        self.dimX = dimX
        self.dimY = dimY
        self.dimZ = dimZ
        self.weight = weight
        self.measureUnit = measureUnit
        self.quantityRequested = "1"
        self.quantitySold = "0"
        self.quantityStockout = "0"
        self.netPricePerUnit = netPricePerUnit
        self.vatPerUnit = vatPerUnit
        self.costPerUnit = costPerUnit
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}
