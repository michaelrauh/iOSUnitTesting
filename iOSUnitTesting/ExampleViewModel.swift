import Foundation

protocol ResponseDelegate {
    func onSuccess (result: Any) -> Void
    func onFailure(error: Error) -> Void
}

extension ResponseDelegate {
    func onFailure(error: Error) {
        print("PANIC")
        print(error)
    }
}

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
