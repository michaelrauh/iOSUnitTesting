import Foundation
import ObjectMapper

// TODO unspike

class Pokemon: Mappable {
    var name: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        name    <- map["name"]
    }
    
    init() {}
}
