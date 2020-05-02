import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.sqlite(.memory), as: .sqlite)
    app.migrations.add(CreateCompany())
    app.migrations.add(CreateProduct())
    app.migrations.add(CreateAddress())
    app.migrations.add(CreateAddressToCompany())
    app.migrations.add(CreateContactInfo())
    app.migrations.add(CreateCustomer())
    app.migrations.add(CreatePaymentMethod())
    app.migrations.add(CreateTaxType())
    app.migrations.add(CreateAddressToCustomer())
    app.migrations.add(CreateContactInfoToCustomer())
    
    
    // register routes
    try routes(app)
}
