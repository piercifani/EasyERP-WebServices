import Foundation
import Fluent

final class ParcelPositions: Model {
    // Name of the table or collection.
    static let schema = "parcelPositions"
    
    // Unique identifier for this salesOrder.
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "parcelHeader_id")
    var parcelHeader: ParcelHeader
    
    // deliveryPositionID
    @Field(key: "deliveryPositionId")
    var deliveryPositionId: UUID
    
    // deliveryPositionInternalID
    @Field(key: "deliveryPositionInternalID")
    var deliveryPositionInternalID: Int
    
    // salesOrderPositionID
    @Field(key: "salesOrderPositionId")
    var salesOrderPositionId: UUID

    // salesOrderPositionID
    @Field(key: "salesOrderPositionInternalId")
    var salesOrderPositionInternalId: Int
    
    // budgetHeaderID
    @Field(key: "salesOrderHeaderId")
    var salesOrderHeaderId: UUID
    
    // budgetHeaderID
    @Field(key: "budgetHeaderId")
    var budgetHeaderId: UUID
    
    // InternalID
    @Field(key: "internalID")
    var internalID: Int
    
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
    
     
    //Creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    //Modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    

    
    //INVOICE
    
    
    
    // Creates a new, empty sales order
    init() { }
    
    init(id: UUID? , parcelHeader_id: ParcelHeader.IDValue, salesOrderPositionId : UUID , salesOrderPositionInternalId : Int , salesOrderHeaderId : UUID , budgetHeaderId: UUID, internalID : Int , productName : String, EAN : String, photoURL : String , dimX : String , dimY: String, dimZ : String , weight : String, measureUnit : String  , deliveryPositionId : UUID , deliveryPositionInternalID : Int ) {
        self.id = id
        self.$parcelHeader.id = parcelHeader_id
        
        self.budgetHeaderId = budgetHeaderId
        self.salesOrderHeaderId = salesOrderHeaderId
        self.salesOrderPositionId = salesOrderPositionId
        self.salesOrderPositionInternalId = salesOrderPositionInternalId
        self.deliveryPositionId = deliveryPositionId
        self.deliveryPositionInternalID = deliveryPositionInternalID
        
        
        self.internalID = internalID
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

        self.creationDate = Date()
        self.modificationDate = Date()
  
    }
}
