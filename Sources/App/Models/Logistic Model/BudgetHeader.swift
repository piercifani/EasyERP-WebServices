import Foundation
import Fluent

final class BudgetHeader: Model {
    // Name of the table or collection.
    static let schema = "budgetHeader"
    
    // Unique identifier for this BudgetHeader.
    @ID(key: .id)
    var id: UUID?
    
    //Expected Date
    @Field(key: "expectedDate")
    var expectedDate: Date
    
    //Creation Date
    @Field(key: "creationDate")
    var creationDate: Date
    
    //Modification Date
    @Field(key: "modificationDate")
    var modificationDate: Date
    
    //Total Gross Amount
    @Field(key: "totalGrossAmount")
    var totalGrossAmount: String
    
    //Total Net Amount
    @Field(key: "totalNetAmount")
    var totalNetAmount: String

    //Total Quantities
    @Field(key: "totalQty")
    var totalQty: String
   
    //----------
    
    @Parent(key: "company_id")
    var company: Company
    
    @Parent(key: "customer_id")
    var customer: Customer
    
    @Parent(key: "delivery_address_id")
    var deliveryAddress: Address
    
    @Parent(key: "billing_address_id")
    var billingAddress: Address
    
    @Parent(key: "contactInfo_id")
    var contactInfo: ContactInfo
    
    @Parent(key: "paymentTerms_id")
    var paymentTerms: paymentTerms
    
    // Creates a new, empty Address.
    init() { }
    
    init(id: UUID?, expectedDate: Date, company_id: Company.IDValue , customer_id : Customer.IDValue, delivery_address_id : Address.IDValue , billing_address_id : Address.IDValue , contactInfo_id : ContactInfo.IDValue , paymentTerms_id : paymentTerms.IDValue) {
        self.id = id
        self.expectedDate = expectedDate
        self.$company.id = company_id
        self.$customer.id = customer_id
        self.$deliveryAddress.id = delivery_address_id
        self.$billingAddress.id = billing_address_id
        self.$contactInfo.id = contactInfo_id
        self.$paymentTerms.id = paymentTerms_id
        
        self.creationDate = Date()
        self.modificationDate = Date()
    }
}

