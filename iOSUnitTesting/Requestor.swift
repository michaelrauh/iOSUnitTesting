import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class Requestor {
    static let shared = Requestor()
    
    private init(){}
    
    func request<T: Mappable, U: ResponseDelegate>(withDelegate delegate: U, withPath path: String, cls: T.Type) {
        
        let URL = "https://pokeapi.co/api/v2/pokemon/\(path)/"
        Alamofire.request(URL)
            .validate(statusCode: 200...299)
            .responseObject { (response: DataResponse<T>) in
                
            switch response.result {
            case .success:
                let object = response.result.value
                delegate.onSuccess(result: object as Any)
            case .failure(let error):
                delegate.onFailure(error: error)
            }
        }
    }
}
