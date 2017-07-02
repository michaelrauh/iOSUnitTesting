import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

protocol ResponseDelegate {
    func onSuccess (result: Pokemon?) -> Void
    func onFailure(error: Error) -> Void
}

extension ResponseDelegate {
    func onFailure(error: Error) {
        print("PANIC")
        print(error)
    }
}

class responseHandler: ResponseDelegate {
    func onSuccess(result: Pokemon?) {
        print(result?.name as Any)
    }
}

class Requestor {
    static let shared = Requestor()
    
    private init(){}
    
    func request<T: Mappable>(withDelegate delegate: ResponseDelegate, withPath path: String, cls: T.Type) {
        
        let URL = "https://pokeapi.co/api/v2/pokemon/\(path)/"
        Alamofire.request(URL)
            .validate(statusCode: 200...299)
            .responseObject { (response: DataResponse<T>) in
                
                
                switch response.result {
                case .success:
                    let pokemon = response.result.value
                    delegate.onSuccess(result: pokemon as! Pokemon?)
                case .failure(let error):
                    delegate.onFailure(error: error)
                }
        }
    }
}

class ExampleViewModel {
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(withDelegate delegate: ResponseDelegate, withPath path: String) {
        Requestor.shared.request(withDelegate: delegate, withPath: path, cls: Pokemon.self)
    }
}
