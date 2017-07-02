import Foundation

class ExampleViewModel: ResponseDelegate {
    
    var viewDelegate: ViewDelegate?
    var pokemonName: String?
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withPath path: String) {
        Requestor.shared.request(withDelegate: self, withPath: path, cls: Pokemon.self)
    }
    
    func onSuccess(result: Any) {
        let pokemon = result as! Pokemon
        pokemonName = pokemon.name
        viewDelegate?.onSuccess()
    }
}
