import Foundation
import UIKit

class Navigator {
    func show(caller: UIViewController, destination: String) {
        let s = UIStoryboard(name: "Main", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: destination)
        caller.show(vc, sender: nil)
    }
}
