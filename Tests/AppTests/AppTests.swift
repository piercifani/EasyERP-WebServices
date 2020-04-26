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
        let company = Company(name: "Contoso")
        try company.save(on: app.db).wait()
        guard let fetchedCompany = try Company.find(company.id, on: app.db).wait() else {
            throw "Unwrap Failed"
        }
        XCTAssertNotNil(fetchedCompany.id)
    
        /// Now add a product
        let product1 = Product(name: "Product 1", company_id: company.id!)
        try product1.save(on: app.db).wait()
        XCTAssertNotNil(product1.id)
        XCTAssertNotNil(product1.$company.id == fetchedCompany.id)
        
        guard let fetchedCompany2 = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, fetchedCompany.id!)
            .with(\.$products)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        XCTAssert(fetchedCompany2.products[0].name == product1.name)
    }
}


extension String: Swift.Error {
    
}
