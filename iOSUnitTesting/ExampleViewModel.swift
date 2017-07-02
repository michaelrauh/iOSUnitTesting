import Foundation

class responseHandler: ResponseDelegate {
    func onSuccess(result: Any) {
        let pokemon = result as! Pokemon
        print(pokemon.name as Any)
    }
}

class ExampleViewModel {
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withDelegate delegate: responseHandler, withPath path: String) {
        Requestor.shared.request(withDelegate: delegate, withPath: path, cls: Pokemon.self)
    }
}
