import Foundation
import Fluent

final class addressToObject: Model {
    // Name of the table or collection.
    static let schema = "addressToObject"

    // Unique identifier for this addressToObject.
    @ID(key: .id)
    var id: UUID?

    @Children(key: "objectId")
     var objectId: UUID?
    
    // Creates a new, empty addressToObject.
    init() { }

    init(id: UUID?, objectId: UUID?) {
        self.id = id
        self.objectId = objectId
    }
}
