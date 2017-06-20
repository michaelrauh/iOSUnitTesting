import UIKit

class ViewController: UIViewController {

    @IBOutlet var someLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text = "This is some text"
    }
}

