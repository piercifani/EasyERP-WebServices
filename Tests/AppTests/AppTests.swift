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
    
    struct salesOrderPosition {
        var _budgetHeaderId: UUID
        var _productName: String
        var _EAN: String
        var _photoURL: String
        var _dimX: String
        var _dimY: String
        var _dimZ: String
        var _weight: String
        var _measureUnit: String
        var _quantitySold: String
        var _quantityStockout: String
        var _netPricePerUnit: String
        var _vatPerUnit: String
        var _costPerUnit: String
    }
    
    func testCreateCompany() throws {
        let companyId = try _createCompany()
        try _addProducts(companyID: companyId)
        try _addAddressesCompany(companyID: companyId)
        let customerId = try _createCustomer(companyID: companyId)
        try _addCustomerInfo(customerID: customerId)
        try _paymentTerms (customerID: customerId)
        try _addTaxType(companyID: companyId)
        try _addTaxTypeToProducts(companyID: companyId)
        
        // CREATE BUDGETS
        
        // crear budget1 con dos productos
        
        let budgetHeaderId1 = try _createBudgetHeader(companyID: companyId)
        var selectProduct = try _pickUpProductToAddIntoBudgetId(description: "Coca-cola")
        try _addPositionToBudgetHeader(budgetHeaderId: budgetHeaderId1, product: selectProduct)
        selectProduct = try _pickUpProductToAddIntoBudgetId(description: "Fanta")
        try _addPositionToBudgetHeader(budgetHeaderId: budgetHeaderId1, product: selectProduct)
        try _checkBudget (budgetHeaderId : budgetHeaderId1)
        
        // crear budget2 con dos productos
        
        let budgetHeaderId2 = try _createBudgetHeader(companyID: companyId)
        selectProduct = try _pickUpProductToAddIntoBudgetId(description: "Coca-cola")
        try _addPositionToBudgetHeader(budgetHeaderId: budgetHeaderId2, product: selectProduct)
        selectProduct = try _pickUpProductToAddIntoBudgetId(description: "Fanta")
        try _addPositionToBudgetHeader(budgetHeaderId: budgetHeaderId2, product: selectProduct)
        try _checkBudget (budgetHeaderId : budgetHeaderId2)
        
        
        // Create SALES ORDERS
        
        // PENDIENTE: return NEW budgets (budgets that havent been use in any sales order)
        //let availableBudgets = try _getBudgetsInStatus(customerID: customerId, Status: "NEW")
        // ahora lo tengo forzado con el array
        
        let availableBudgets = [budgetHeaderId1,budgetHeaderId2]
        
        // filtar la information de los budgets, proponer entre las direcciones, pero la cabecera de la sales order debe ser unica
        
        //let [availableSalesOrderPositions] =
        
        try _getAllAvailablePositionsForSalesOrderCreation (budgetHeaderIds: availableBudgets)
        
        // crear sales order (posicion 1 - cocacola budget1 / posicion 2 - fanta del budget 2)
        
        let salesOrderHeaderId = try _createSalesOrderHeader(companyID: companyId , customerID:  customerId)
        
        
        
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
        
        var customerAddress1 = Address(id: nil, address1: "Ps. Maragall 177", address2: "3/3", zipCode: "08025", city: "Barcelona", zoneCode: "Barcelona", countryCode: "SP")
        try customerAddress1.save(on: app.db).wait()
        
        var pivotAddressToCustomer1 = AddressToCustomer(addressId: customerAddress1.id , customerId: customerID)
        try pivotAddressToCustomer1.save(on: app.db).wait()
        
        customerAddress1 = Address(id: nil, address1: "av.Diagonal 134", address2: "1/1", zipCode: "08003", city: "Barcelona", zoneCode: "Barcelona", countryCode: "SP")
        try customerAddress1.save(on: app.db).wait()
        
         pivotAddressToCustomer1 = AddressToCustomer(addressId: customerAddress1.id , customerId: customerID)
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
    
    func _createBudgetHeader(companyID: UUID) throws -> UUID {
        
        guard let fetchedCompany = try Company
            .query(on: app.db)
            .filter(\.$id, .equal, companyID)
            .with(\.$customer)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        let customerBudget = fetchedCompany.customer.first (where: { $0.name == "Dini" })
        
        guard let fetchedCustomer = try Customer
            .query(on: app.db)
            .filter(\.$id, .equal, (customerBudget?.id)!)
            .with(\.$addresses)
            .with(\.$paymentTerms)
            .with(\.$contactInfo)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        
        // busca el id dentro de las direcciones del customer para tener delivery addresss
        let deliveryAddressIdForBudget = fetchedCustomer.addresses.first (where: { $0.address1 == "Ps. Maragall 177" })
        
        // busca el id dentro de las direcciones del customer para tener billing addresss
        let billingAddressIdForBudget = fetchedCustomer.addresses.first (where: { $0.address1 == "av.Diagonal 134" })
        
        // busca el id dentro de los payment terms del customer
        let paymentTermIdForBudget = fetchedCustomer.paymentTerms.first (where: { $0.description == "cash" })
        
        // busca el id dentro los contact del customer
        
        let contactInfoIdForBudget = fetchedCustomer.contactInfo.first (where: { $0.name == "Rosalia"  })
        
        
        //@PIER: ¿por que no funciona nil en el id:?? y tengo que forzar UUID
        
        
        let budgetHeader = BudgetHeader(id: UUID(), expectedDate: Date(), company_id: companyID, customer_id: (customerBudget?.id)!, delivery_address_id: (deliveryAddressIdForBudget?.id)!, billing_address_id: (billingAddressIdForBudget?.id)!, contactInfo_id: (contactInfoIdForBudget?.id)!, paymentTerms_id: (paymentTermIdForBudget?.id)!)
        try budgetHeader.save(on: app.db).wait()
        
        
        //buscando en la tabla de Headers pedidos del cliente customerBudget.id
        
        guard let fetchedBudgetHeader = try BudgetHeader
            .query(on: app.db)
            .filter(\.$customer.$id, .equal, (customerBudget?.id)!)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        XCTAssertNotNil(fetchedBudgetHeader.id)
        XCTAssertNotNil(fetchedBudgetHeader.$deliveryAddress.value?.$city.value == "Barcelona")
        XCTAssertNotNil(fetchedBudgetHeader.$deliveryAddress.value?.$address1.value == "Ps. Maragall 177")
        XCTAssertNotNil(fetchedBudgetHeader.$billingAddress.value?.$address1.value == "av.Diagonal 134")
        XCTAssertNotNil(fetchedBudgetHeader.$customer.value?.$name.value == "Dini")
        XCTAssertNotNil(fetchedBudgetHeader.$customer.value?.$vat.value == "79871312Y")
        XCTAssertNotNil(fetchedBudgetHeader.$contactInfo.value?.$phone1.value == "696969696")
        XCTAssertNotNil(fetchedBudgetHeader.$paymentTerms.value?.$rate.value == "100")
        
        
        return (fetchedBudgetHeader.id)!
        
    }
    
    func _pickUpProductToAddIntoBudgetId (description: String) throws -> Product  {
        // New customer in companyID
        
        guard let fetchedProduct = try Product
            .query(on: app.db)
            .filter(\.$name, .equal, description)
            .first()
            .wait() else {
                throw "Unwrap Failed"
        }
        
        XCTAssertNotNil(fetchedProduct.id)
        
        return fetchedProduct
    }
    
    
    
    
    func _addPositionToBudgetHeader(budgetHeaderId: UUID , product: Product) throws  {
        
        // dependiendo del pais y region del delivey address se buscaria el impuesto correspondiente
        
        _ = product.$taxType.value?.first(where: {_ in 0.description == "Impuesto General"} )
        
        // usaria el taxType?.$rate multiplicarlo por el precio net unitario y calcular
        
        let newProductIntoTheBudget = BudgetPositions(id: nil, headerBudget_id: budgetHeaderId, product_id: product.id! , quantityRequested: 4, quantitySold: "0", quantityStockout : "0", netPricePerUnit: "10.00", vatPerUnit: "123", totalVatPerProduct: "132", totalGrossPricePerProduct: "123", costPerUnit: "123", totalCostPerProduct: "123" )
        try newProductIntoTheBudget.save(on: app.db).wait()
        
    }
    
    func _checkBudget (budgetHeaderId: UUID ) throws  {
           
           //check that the budget is correctly store in the db
        
           guard let fetchedBudget = try BudgetHeader
               .query(on: app.db)
               .filter(\.$id, .equal, budgetHeaderId)
               .with(\.$budgetPositions)
               .first()
               .wait() else {
                   throw "Unwrap Failed"
           }
           
           XCTAssertNotNil(fetchedBudget.id)
        
        
        XCTAssertNotNil(fetchedBudget.$customer.name == "Dini")
        XCTAssertNotNil(fetchedBudget.$deliveryAddress.value?.$address1.value == "Ps. Maragall 177")
        XCTAssertNotNil(fetchedBudget.budgetPositions.count == 2)
           
       }
        
    func _createSalesOrderHeader(companyID: UUID , customerID : UUID) throws -> UUID {
        
        //PENDINTE DE PASAR LA INFO FILTRADA DEL GET THE BUDGETS
        
        let salesOrderHeader = SalesOrderHeader(id: nil, company_id: companyID, customerId: customerID, customerName: "testName", customerVatNumber: "test12323412", contactInfoName: "testAlan", contactInfoLastName: "testOsers", contactInfoPhone1: "73786123123", contactInfoPhone2: "00000000", contactInfoEmail1: "aa@aa.com", contactInfoEmail2: "N/A", deliveryAddress1: "ps. 123 8381", deliveryAddress2: "p1 p2", deliveryZipCode: "08013", deliveryCity: "Barcelona", deliveryZoneCode: "Barcelona", deliveryCountryCode: "SP", billingAddress1: "uduudud", billingAddress2: "12314", billingZipCode: "08103", billingCity: "Barcelona", billingZoneCode: "Barcelona", billingCountryCode: "SP")
    
        try salesOrderHeader.save(on: app.db).wait()
        
        return (salesOrderHeader.id!)
    }
    
    
    func _getAllAvailablePositionsForSalesOrderCreation(budgetHeaderIds : [UUID] ) throws {
            
        var availableBudgetHeaders = [BudgetHeader]()
        
            for i in budgetHeaderIds {
                guard let fetchedBudgetHeaders = try BudgetHeader
                        .query(on: app.db)
                        .filter(\.$id, .equal, i)
                        .with(\.$budgetPositions)
                        .first()
                        .wait() else {
                            throw "Unwrap Failed"
                    }
                availableBudgetHeaders.append(fetchedBudgetHeaders)
            }
        
        XCTAssertNotNil(availableBudgetHeaders.count == 2)
        
        var availableSalesOrdersPositions = [salesOrderPosition]()
        
        for j in 0...availableBudgetHeaders.count-1 {
            for x in 0...availableBudgetHeaders[j].budgetPositions.count-1 {
                guard let fetchedProductData = try Product
                .query(on: app.db)
                .filter(\.$id, .equal, availableBudgetHeaders[j].budgetPositions[x].$product.id)
                .first()
                .wait() else {
                    throw "Unwrap Failed"
                }
                
                
                
                for _ in 1...(availableBudgetHeaders[j].budgetPositions[x].$quantityRequested.value)! {
                      availableSalesOrdersPositions.append(salesOrderPosition.init(
                        _budgetHeaderId: availableBudgetHeaders[j].id!,
                        _productName: fetchedProductData.name,
                        _EAN: fetchedProductData.EAN,
                        _photoURL: fetchedProductData.photoURL,
                        _dimX: fetchedProductData.dimX,
                        _dimY: fetchedProductData.dimY,
                        _dimZ: fetchedProductData.dimZ,
                        _weight: fetchedProductData.weight,
                        _measureUnit: fetchedProductData.measureUnit,
                        _quantitySold: availableBudgetHeaders[j].budgetPositions[x].$quantitySold.value!,
                        _quantityStockout: availableBudgetHeaders[j].budgetPositions[x].$quantityStockout.value!,
                        _netPricePerUnit: availableBudgetHeaders[j].budgetPositions[x].$netPricePerUnit.value!,
                        _vatPerUnit: availableBudgetHeaders[j].budgetPositions[x].$vatPerUnit.value!,
                        _costPerUnit: availableBudgetHeaders[j].budgetPositions[x].$costPerUnit.value!))
                 }
            }
        }
        
        for x in 0...3{
            print(x)
            print(availableSalesOrdersPositions[x]._productName)
        }
       

    }
        
        
        
        
    
    
    /*func _getBudgetsInStatus(customerID : UUID , Status : String) throws -> BudgetHeader {
        
        guard let fetchedBudgetHeaders = BudgetHeader
            .query(on: app.db)
            .filter(\.$customer.$id, .equal, customerID)
            .filter(\.$globalStatus, .equal, Status)
             else {
                throw "Unwrap Failed"
        }
        
        XCTAssertNotNil(fetchedBudgetHeader)

        return fetchedBudgetHeader
    }*/
    
}




extension String: Swift.Error {
    
}
