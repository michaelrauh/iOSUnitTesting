import Quick
import Nimble
import Moxie
@testable import iOSUnitTesting

class ViewControllerTests: QuickSpec {
    override func spec() {
        describe("ViewController") {
            var subject: ViewController!
            var mockNavigator: MockNavigator!
            var mockViewModel: MockExampleViewModel!
            
            beforeEach {
                subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
                
                mockNavigator = MockNavigator()
                mockViewModel = MockExampleViewModel()
                
                subject.navigator = mockNavigator
                subject.viewModel = mockViewModel
            }
            
            describe("viewDidLoad") {
                beforeEach {
                    mockViewModel.stub(function: "calculate", return: 10)
                    _ = subject.view
                }
                
                it("sets a label") {
                    expect(subject.someLabel.text).to(equal("This is some text"))
                }
                
                it("sets a label based upon a view model") {
                    expect(subject.thirdLabel.text).to(equal("your number is 10"))
                }
            }
            
            context("when tapping a button") {
                beforeEach {
                    _ = subject.view
                    subject.changeTextButton.sendActions(for: .touchUpInside)
                }
                
                it("sets text") {
                    expect(subject.otherLabel.text).to(equal("This is different text"))
                }
            }
            
            context("when tapping a different button") {
                beforeEach {
                    _ = subject.view
                    subject.otherButton.sendActions(for: .touchUpInside)
                }
                
                it("calls the navigator") {
                    expect(mockNavigator.invoked(function: "show", with: [subject, "otherVC"])).to(beTrue())
                }
            }
            
            context("when tapping the network button") {
                beforeEach {
                    _ = subject.view
                    subject.viewModel.pokemonName = "Pikachu"
                    subject.pokemonIndex.text = "5"
                    subject.networkButton.sendActions(for: .touchUpInside)
                }
                
                it("asks the view model to make a call") {
                    expect(mockViewModel.invoked(function: "makeCall", with: [subject, "5"])).to(beTrue())
                }
                
                it("sets the label for the pokemon name") {
                    // TODO: Capture the first argument of makeCall and call onSuccess on it
                    
                    subject.onSuccess()
                    expect(subject.pokemonNameLabel.text).to(equal("Pikachu"))
                }
            }
        }
    }
}

    
class MockNavigator: Navigator, Mock {
    
    var moxie = Moxie()
    
    override func show(caller: UIViewController, destination: String) {
        
        record(function: "show", wasCalledWith: [caller, destination])
        
    }
}

class MockExampleViewModel: ExampleViewModel, Mock {
    
    var moxie = Moxie()
    
    override func calculate(forNumber number: Int) -> Int {
        return value(forFunction: "calculate") ?? 0
    }
    
    override func makeCall(withDelegate requestDelegate: ViewDelegate, withPath path: String) {
        record(function: "makeCall", wasCalledWith: [requestDelegate, path])
    }
}
