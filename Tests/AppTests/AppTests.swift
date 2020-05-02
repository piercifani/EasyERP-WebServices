@testable import App
import Vapor
import XCTVapor
import Fluent

final class AppTests: XCTestCase {
    
    private var app: Application!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = Application(.testing)
        try configure(app)
        try app.boot()
        try app.autoMigrate().wait()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        app.shutdown()
        app = nil
    }
    
    /// MARK: Tests
    
    func testCreateCompany() throws {
        let companyId = try _createCompany()
        try _addProducts(companyID: companyId)
        try _addAddressesCompany(companyID: companyId)
        let customerId = try _createCustomer(companyID: companyId)
        try _addCustomerInfo(customerID: customerId)
        try _paymentTerms (customerID: customerId)
        try _addTaxType(companyID: companyId)
        try _addTaxTypeToProducts(companyID: companyId)
    }
    
    func _createCompany() throws -> UUID {
        /// Create and fetch a company
        let company = Company(id: nil, name: "Contoso", companyVatNumber: "Y798032K", mainCurrency: "EUR", mainLanguage: "ES")
        try company.save(on: app.db).wait()
        guard let fetchedCompany = try Company.find(company.id, on: app.db).wait() else {
            throw "Company not found"
        }
        XCTAssertNotNil(fetchedCompany.id)
        XCTAssert(fetchedCompany.id == company.id)
        XCTAssert(fetchedCompany.name == company.name)
        return company.id!
    }
    
    func _addAddressesCompany(companyID: UUID) throws {
        /// Lets start with addresses
        let address = Address(id: nil, address1: "Carrer dels Tiradors 6", address2: "2º 2º", zipCode: "08003", city: "Barcelona", zoneCode: "Barcelona", countryCode: "ESPAÑA")
        try address.save(on: app.db).wait()
        
        let pivotAddress = AddressToCompany.init(addressId: address.id, companyId: companyID)
        try pivotAddress.save(on: app.db).wait()
        
        /// Verify that the products are there
        guard let fetchedCompany3 = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, companyID)
            .with(\.$addresses)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        XCTAssert(fetchedCompany3.addresses.count > 0)
        XCTAssertNotNil(fetchedCompany3.addresses.first(where: {$0.address1 ==  "Carrer dels Tiradors 6" }))
    }
    
    func _addProducts(companyID: UUID) throws {
        /// Now add a product
        
        let product1 = Product(id: nil, name: "Coca-cola", productType: "FP", supplierReferenceId: "1231-998123", EAN: "87104018502135", LongDesc: "Lata de coca cola, roja, sabor cola", photoURL: "https://images-na.ssl-images-amazon.com/images/I/71CqlCwfFuL._AC_SL1500_.jpg" , dimX: "10" , dimY : "10", dimZ : "25" , weight: "0.3" ,measureUnit: "UN" , company_id: companyID)
        try product1.save(on: app.db).wait()
        XCTAssertNotNil(product1.id)
        XCTAssertNotNil(product1.$company.id == companyID)
                
        /// Now add a product2
        let product2 = Product(id: nil, name: "Fanta", productType: "FP", supplierReferenceId: "1231-99124523", EAN: "871045134502135", LongDesc: "Lata de fanta, naranja, sabor naranja", photoURL: "https://m.media-amazon.com/images/I/516pZFbo+AL._AC_SS350_.jpg" , dimX: "10" , dimY : "10", dimZ : "25" , weight: "0.3" ,measureUnit: "UN" , company_id: companyID)
        try product2.save(on: app.db).wait()
        XCTAssertNotNil(product2.id)
        XCTAssertNotNil(product2.$company.id == companyID)

        /// Verify that the products are there
        guard let fetchedCompany = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, companyID)
            .with(\.$products)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        XCTAssert(fetchedCompany.products.count == 2)
        XCTAssertNotNil(fetchedCompany.products.first(where: { $0.name == "Coca-cola" }))
        XCTAssertNotNil(fetchedCompany.products.first(where: { $0.name == "Fanta" }))
    }
    
    func _createCustomer(companyID: UUID) throws -> UUID  {
        // New customer in companyID
        
        let customer1 = Customer(id: nil, name: "Dini", vat: "79871312Y", company_id: companyID)
        try customer1.save(on: app.db).wait()
        XCTAssertNotNil(customer1.id)
        XCTAssertNotNil(customer1.$company.id == companyID)
        
        return customer1.id!
    }
    
    func _addCustomerInfo(customerID: UUID) throws {
        // add and address into the  New customer
        
        let customerAddress1 = Address(id: nil, address1: "Ps. Maragall 177", address2: "3/3", zipCode: "08025", city: "Barcelona", zoneCode: "Barcelona", countryCode: "SP")
        try customerAddress1.save(on: app.db).wait()
        
        let pivotAddressToCustomer1 = AddressToCustomer(addressId: customerAddress1.id , customerId: customerID)
        try pivotAddressToCustomer1.save(on: app.db).wait()
        
        // add and contactinfo into the  New customer
        
        let contactInfo1 = ContactInfo(id: nil, name: "Rosalia", lastName: "Mola", email1: "rosalia@mola.com", email2: "11@qq.com", phone1: "696969696", phone2: "555509823", website: "www.rosalia.com")
        try contactInfo1.save(on: app.db).wait()
        
        let pivotContactInfo = ContactInfoToCustomer(contactInfoId: contactInfo1.id , customerId: customerID)
        try pivotContactInfo.save(on: app.db).wait()
        
        XCTAssertNotNil(pivotContactInfo.$customerId)
        
        /// Verify that the addresses are there
               guard let fetchedCustomer = try Customer
                   .query(on: app.db)
                   .filter(\.$id, .equal, customerID)
                   .with(\.$addresses)
                   .with(\.$contactInfo)
                   .first()
                   .wait() else {
                       throw "Unwrap Failed"
               }
        
        XCTAssertNotNil(fetchedCustomer.addresses.first(where: { $0.address1 == "Ps. Maragall 177" }))
        XCTAssertNotNil(fetchedCustomer.contactInfo.first(where: { $0.name == "Rosalia" }))
        
    }
    
    func _paymentTerms(customerID: UUID) throws  {
        // New customer in companyID
        
        let paymentTerms1 = paymentTerms(id: nil, description: "cash", dueDate: "0", rate: "100", customerID: customerID)
        try paymentTerms1.save(on: app.db).wait()
        
        let paymentTerms2 = paymentTerms(id: nil, description: "30 días el 20%", dueDate: "30", rate: "20", customerID: customerID)
        try paymentTerms2.save(on: app.db).wait()
        
        let paymentTerms3 = paymentTerms(id: nil, description: "60 días el 80%", dueDate: "60", rate: "80", customerID: customerID)
        try paymentTerms3.save(on: app.db).wait()
            
        
        /// Verify that the paymentMethods are there
        guard let fetchedCustomer = try Customer
            .query(on: app.db)
            .filter(\.$id, .equal, customerID)
            .with(\.$paymentTerms)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        XCTAssert(fetchedCustomer.paymentTerms.count == 3)
        XCTAssertNotNil(fetchedCustomer.paymentTerms.first(where: { $0.description == "60 días el 80%" }))
        XCTAssertNotNil(fetchedCustomer.paymentTerms.first(where: { $0.description == "cash" }))
        
    }
    
    func _addTaxType(companyID: UUID) throws {
        
        let taxType1 = taxType(id: nil, description: "Impuesto General", country: "SP", region: "Peninsula", rate: "0.21", company_id: companyID)
        try taxType1.save(on: app.db).wait()
        
        let taxType2 = taxType(id: nil, description: "Impuesto Reducido", country: "SP", region: "Peninsula", rate: "0.1", company_id: companyID)
        try taxType2.save(on: app.db).wait()
        
        let taxType3 = taxType(id: nil, description: "Impuesto Super Reducido", country: "SP", region: "Peninsula", rate: "0.04", company_id: companyID)
        try taxType3.save(on: app.db).wait()
        
        let taxType4 = taxType(id: nil, description: "Impuesto Primera Necesidad Canarias", country: "SP", region: "Canarias", rate: "0.0", company_id: companyID)
        try taxType4.save(on: app.db).wait()
        
        let taxType5 = taxType(id: nil, description: "Impuesto Reducido", country: "SP", region: "Canarias", rate: "0.03", company_id: companyID)
        try taxType5.save(on: app.db).wait()
        
        let taxType6 = taxType(id: nil, description: "Impuesto General Canarias", country: "SP", region: "Canarias", rate: "0.07", company_id: companyID)
        try taxType6.save(on: app.db).wait()
        
        XCTAssertNotNil(taxType6.id)
        XCTAssertNotNil(taxType6.$company.id == companyID)
        
        /// Verify that the taxType are there
        guard let fetchedCompany = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, companyID)
            .with(\.$taxType)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        XCTAssert(fetchedCompany.taxType.count == 6)
        XCTAssertNotNil(fetchedCompany.taxType.first(where: { $0.description == "Impuesto General Canarias" }))
        
    }
    
    func _addTaxTypeToProducts(companyID: UUID) throws  {
        
        // todos los productos de la company
        
        guard let fetchedCompany = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, companyID)
            .with(\.$products)
            .with(\.$taxType)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        //busco el Id de una product en particular del array
        
        let product1 = fetchedCompany.products.first (where: { $0.name == "Coca-cola" })
        
        // busco el id del taxtype que quiero
        
        var taxType1 = fetchedCompany.taxType.first (where: { $0.description == "Impuesto General" })
        
        //asigno el primer impuesto taxttype al producto
        
        var pivotTaxTypeToProducts = TaxTypeToProducts(taxTypeId: taxType1?.id, productsId: product1?.id)
        try pivotTaxTypeToProducts.save(on: app.db).wait()
    
        taxType1 = fetchedCompany.taxType.first (where: { $0.description == "Impuesto General Canarias" })
        pivotTaxTypeToProducts = TaxTypeToProducts(taxTypeId: taxType1?.id, productsId: product1?.id)
        try pivotTaxTypeToProducts.save(on: app.db).wait()
        
        
        guard let fetchedProduct = try Product
            .query(on: app.db)
            .filter(\.$name, .equal, "Coca-cola")
            .with(\.$taxType)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        //comprueba que en el producto coca-cola se pueden usar los dos tipos de impuestos
        
        XCTAssertNotNil(fetchedProduct.taxType.first(where: { $0.description == "Impuesto General Canarias" }))
        XCTAssertNotNil(fetchedProduct.taxType.first(where: { $0.description == "Impuesto General" }))
    }
    
}


extension String: Swift.Error {
    
}
