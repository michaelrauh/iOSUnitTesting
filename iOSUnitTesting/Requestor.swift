import ObjectMapper
import AlamofireObjectMapper
import Alamofire

class Requestor {
    static let shared = Requestor()
    
    private init(){}
    
    func request<T: ResponseDelegate>(withDelegate delegate: T, withPath path: String) {
        
        let URL = "https://pokeapi.co/api/v2/pokemon/\(path)/"
        Alamofire.request(URL)
            .validate(statusCode: 200...299)
            .responseObject { (response: DataResponse<T.T>) in
                
            switch response.result {
            case .success:
                let object = response.result.value
                delegate.onSuccess(result: object as T.T?)
            case .failure(let error):
                delegate.onFailure(error: error)
            }
        }
    }
}
