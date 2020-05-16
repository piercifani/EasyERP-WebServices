import Foundation
import Fluent

final class BudgetPositions: Model {
    // Name of the table or collection.
    static let schema = "budgetPositions"
    
    // Unique identifier for this product.
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "headerBudget_id")
    var headerBudget: BudgetHeader
    
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
    
    @Field(key: "totalVatPerProduct")
    var totalVatPerProduct: String
    
    @Field(key: "totalGrossPricePerProduct")
    var totalGrossPricePerProduct: String
    
    @Field(key: "costPerUnit")
    var costPerUnit: String
    
    @Field(key: "totalCostPerProduct")
    var totalCostPerProduct: String
    
    // product name.
    
    @Siblings(through: ProductsToBudgetPositions.self, from: \.$budgetPositionsId, to: \.$productId)
    var productId: [Product]
    
    // creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    // modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    
  
    
    // Creates a new, empty Galaxy.
    init() { }
    
    init(id: UUID?, headerBudget_id: BudgetHeader.IDValue, quantityRequested: String, quantitySold: String, quantityStockout:String, netPricePerUnit: String, vatPerUnit: String, totalVatPerProduct: String, totalGrossPricePerProduct: String , costPerUnit: String, totalCostPerProduct: String) {
        self.id = id
        self.$headerBudget.id = headerBudget_id
        self.quantityRequested = quantityRequested
        self.quantityStockout = quantityStockout
        self.quantitySold = quantitySold
        self.netPricePerUnit = netPricePerUnit
        self.vatPerUnit = vatPerUnit
        self.totalVatPerProduct = totalVatPerProduct
        self.totalGrossPricePerProduct = totalGrossPricePerProduct
        self.costPerUnit = costPerUnit
        self.totalCostPerProduct = totalCostPerProduct
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}


  