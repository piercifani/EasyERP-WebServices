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
    
    func companyAddresses(req: Request) throws -> EventLoopFuture<[Address]> {
        let companyID: Company.IDValue? = req.parameters.get("id")
        return Company
            .find(companyID, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                try! $0.$companyAddresID
                        .query(on: req.db)
                        .all()
            }
    }
    
    func addAddress(req: Request) throws -> EventLoopFuture<[Address]> {
        guard let companyID: Company.IDValue = req.parameters.get("id") else { throw Abort(.notFound) }
        guard let addressID: Address.IDValue = try? req.content.decode(Company.self).id else { throw Abort(.notFound) }
        _ = addressToCompany(addressId: addressID, companyId: companyID).save(on: req.db)
        return try self.companyAddresses(req: req)
    }
    
    func testCreateCompany() throws {
        
        var company = Company(id: nil, name: "Hello", companyVatNumber: "123456A", mainCurrency: "EUR", mainLanguage: "SP")
        try company.save(on: app.db).wait()
        let fetchedCompany = try Company.find(company.id, on: app.db).wait()
        XCTAssertNotNil(fetchedCompany)
        
        let Product1 = Product(id: nil, name: "product 1", company_id: company.id!)
        try Product1.save(on: app.db).wait()
        let fetchedProduct1 = try Product.find(Product1.id, on: app.db).wait()
        XCTAssertNotNil(fetchedProduct1)
        
        let address1 = Address(id: nil, address1: "calle Lala 193", address2: "5/1", zipCode: "08012", city: "Barcelona", zoneCode: "Barcelona", countryCode: "Spain")
        try address1.save(on: app.db).wait()
        
        let address2 = Address(id: nil, address1: "av. 12", address2: "1/1", zipCode: "08022", city: "Madrid", zoneCode: "Madrid", countryCode: "Spain")
        try address2.save(on: app.db).wait()
        
        

    }
}
