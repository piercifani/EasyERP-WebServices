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
        
        /// Create and fetch a company
        let company = Company(id: nil, name: "Contoso", companyVatNumber: "Y798032K", mainCurrency: "EUR", mainLanguage: "ES")
        try company.save(on: app.db).wait()
        guard let fetchedCompany = try Company.find(company.id, on: app.db).wait() else {
            throw "Company not found"
        }
        XCTAssertNotNil(fetchedCompany.id)
        XCTAssert(fetchedCompany.id == company.id)
        XCTAssert(fetchedCompany.name == company.name)

        /// Now add a product
        let product1 = Product(id: nil, name: "Coca-Cola", company_id: fetchedCompany.id!)
        try product1.save(on: app.db).wait()
        XCTAssertNotNil(product1.id)
        XCTAssertNotNil(product1.$company.id == fetchedCompany.id)
                
        /// Now add a product2
        let product2 = Product(id: nil, name: "Fanta", company_id: fetchedCompany.id!)
        try product2.save(on: app.db).wait()
        XCTAssertNotNil(product2.id)
        XCTAssertNotNil(product2.$company.id == fetchedCompany.id)

        guard let fetchedCompany2 = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, fetchedCompany.id!)
            .with(\.$products)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        XCTAssert(fetchedCompany2.products.count == 2)
        XCTAssertNotNil(fetchedCompany2.products.first(where: { $0.name == "Coca-Cola" }))
        XCTAssertNotNil(fetchedCompany2.products.first(where: { $0.name == "Fanta" }))
    }
}


extension String: Swift.Error {
    
}
