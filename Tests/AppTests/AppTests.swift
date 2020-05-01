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
        let id = try _createCompany()
        try _addProducts(companyID: id)
        try _addAddresses(companyID: id)
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
    
    func _addAddresses(companyID: UUID) throws {
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
        let product1 = Product(id: nil, name: "Coca-Cola", company_id: companyID)
        try product1.save(on: app.db).wait()
        XCTAssertNotNil(product1.id)
        XCTAssertNotNil(product1.$company.id == companyID)
                
        /// Now add a product2
        let product2 = Product(id: nil, name: "Fanta", company_id: companyID)
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
        XCTAssertNotNil(fetchedCompany.products.first(where: { $0.name == "Coca-Cola" }))
        XCTAssertNotNil(fetchedCompany.products.first(where: { $0.name == "Fanta" }))
    }
}


extension String: Swift.Error {
    
}
