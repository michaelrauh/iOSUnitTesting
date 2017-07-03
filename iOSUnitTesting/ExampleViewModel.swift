import Foundation

class ExampleViewModel: ResponseDelegate {
    typealias T = Pokemon
    
    var viewDelegate: ViewDelegate?
    var pokemonName: String?
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withPath path: String) {
        Requestor.shared.request(withDelegate: self, withPath: path, cls: Pokemon.self)
    }
    
    func onSuccess(result: T) {
        let pokemon = result
        pokemonName = pokemon.name
        viewDelegate?.onSuccess()
    }
}
