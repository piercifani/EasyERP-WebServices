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
        let someID = UUID()
        let company = Company(id: someID, name: "Hello")
        try company.save(on: app.db).wait()
        let fetchedCompany = try Company.find(someID, on: app.db).wait()
        XCTAssertNotNil(fetchedCompany)
    }
}
