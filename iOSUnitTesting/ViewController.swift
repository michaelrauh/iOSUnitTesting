import UIKit

protocol ViewDelegate {
    func onSuccess() -> Void
}

class ViewController: UIViewController, ViewDelegate {

    @IBOutlet var someLabel: UILabel!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var changeTextButton: UIButton!
    @IBOutlet var otherButton: UIButton!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var networkButton: UIButton!
    @IBOutlet var pokemonIndex: UITextField!
    @IBOutlet var pokemonNameLabel: UILabel!
    
    var navigator = Navigator()
    var viewModel = ExampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someLabel.text = "This is some text"
        let resultNumber = viewModel.calculate(forNumber: 4)
        thirdLabel.text = "your number is \(resultNumber)"
        viewModel.viewDelegate = self
    }
    
    @IBAction func changeTextButtonTapped() {
        otherLabel.text = "This is different text"
    }
    
    @IBAction func otherButtonTapped() {
        navigator.show(caller: self, destination: "otherVC")
    }
    
    @IBAction func networkButtonTapped() {
        viewModel.makeCall(withPath: pokemonIndex.text!)
    }
    
    func onSuccess() {
        pokemonNameLabel.text = viewModel.pokemonName
    }
}

