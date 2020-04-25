@testable import App
import Vapor
import XCTVapor

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
        
        let company = Company(id: nil, name: "Hello")
        try company.save(on: app.db).wait()
        let fetchedCompany = try Company.find(company.id, on: app.db).wait()
        XCTAssertNotNil(fetchedCompany)
        
        let Product1 = Product(id: nil, name: "product 1", company_id: company.id!)
        try Product1.save(on: app.db).wait()
        print(Product1.$company.name)
        XCTAssertNotNil(Product1.$company)

    }
}
