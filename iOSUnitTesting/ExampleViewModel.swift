import Foundation

class ExampleViewModel: ResponseDelegate {
    typealias T = Pokemon
    
    var viewDelegate: ViewDelegate?
    var pokemonName: String?
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withDelegate requestDelegate: ViewDelegate, withPath path: String) {
        self.viewDelegate = requestDelegate
        Requestor.shared.request(withDelegate: self, withPath: path)
    }
    
    func onSuccess(result: T?) {
        let pokemon = result
        pokemonName = pokemon?.name
        viewDelegate?.onSuccess()
    }
}
    
