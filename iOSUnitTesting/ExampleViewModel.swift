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
        print(result?.name)
    }
}

class ExampleViewModel {
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall(delegate: ResponseDelegate) {
        
        // TODO unspike
        
        let URL = "https://pokeapi.co/api/v2/pokemon/1/"
        Alamofire.request(URL)
            .validate(statusCode: 200...299)
            .responseObject { (response: DataResponse<Pokemon>) in
            
            
            switch response.result {
            case .success:
                let pokemon = response.result.value
                delegate.onSuccess(result: pokemon)
            case .failure(let error):
                delegate.onFailure(error: error)
            }
        }
    }
}
