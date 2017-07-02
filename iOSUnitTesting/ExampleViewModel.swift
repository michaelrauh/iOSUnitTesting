import Foundation

class ExampleViewModel: ResponseDelegate {
    
    var viewDelegate: ViewDelegate?
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withPath path: String) {
        Requestor.shared.request(withDelegate: self, withPath: path, cls: Pokemon.self)
    }
    
    func onSuccess(result: Any) {
        let pokemon = result as! Pokemon
        Cache.shared.pokemonName = pokemon.name
        viewDelegate?.onSuccess()
    }
    
    var pokemonName: String {
        return Cache.shared.pokemonName ?? ""
    }
}

class Cache {
    var pokemonName: String?
    
    static let shared = Cache()
    
    private init (){}
}
