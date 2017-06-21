import UIKit

class ViewController: UIViewController {

    @IBOutlet var someLabel: UILabel!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var changeTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text = "This is some text"
    }
    
    @IBAction func changeTextButtonTapped() {
        otherLabel.text = "This is different text"
    }
}

