import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ExampleViewModel {
    
    func calculate(forNumber number: Int) -> Int {
        return number * 2
    }
    
    func makeCall() {
        
        // TODO unspike
        
        let URL = "https://pokeapi.co/api/v2/pokemon/-1/"
        Alamofire.request(URL)
            .validate(statusCode: 200...299)
            .responseObject { (response: DataResponse<Pokemon>) in
            
            
            switch response.result {
            case .success:
                let pokemon = response.result.value
                print(pokemon?.name)
            case .failure(let error):
                print(error)
            }
        }
    }
}
