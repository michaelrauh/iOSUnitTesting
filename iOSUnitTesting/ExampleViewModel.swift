import Foundation

class ExampleViewModel: ResponseDelegate {
    typealias T = Pokemon
    var requestor: RequestorProtocol = Requestor.shared
    
    var viewDelegate: ViewDelegate?
    var pokemonName: String?
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withDelegate requestDelegate: ViewDelegate, withPath path: String) {
        self.viewDelegate = requestDelegate
        requestor.request(withDelegate: self, withPath: path)
    }
    
    func onSuccess(result: T?) {
        pokemonName = result?.name
        viewDelegate?.onSuccess()
    }
}
    
