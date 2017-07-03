import XCTest
import Moxie
@testable import iOSUnitTesting

class iOSUnitTestingTests: XCTestCase {
    var subject: ViewController!
    var mockNavigator: MockNavigator!
    var mockViewModel: MockExampleViewModel!
    
    override func setUp() {
        super.setUp()
        subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        mockNavigator = MockNavigator()
        mockViewModel = MockExampleViewModel()
        
        subject.navigator = mockNavigator
        subject.viewModel = mockViewModel
    }
    
    func testThatALabelIsSetOnViewDidLoad() {
        _ = subject.view
        XCTAssertEqual(subject.someLabel.text, "This is some text")
    }
    
    func testThatALabelIsSetOnButtonTap() {
        _ = subject.view
        subject.changeTextButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(subject.otherLabel.text, "This is different text")
    }
    
    func testThatNavigatorIsCalledOnButtonTap() {
        _ = subject.view
        subject.otherButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockNavigator.invoked(function: "show", with: [subject, "otherVC"]))
    }
    
    func testThatALabelCanBeSetBasedUponAViewModel() {
        mockViewModel.stub(function: "calculate", return: 10)
        _ = subject.view
        XCTAssertEqual(subject.thirdLabel.text, "your number is 10")
    }
    
    func testThatTouchingTheNetworkButtonHitsTheNetwork() {
        _ = subject.view
        subject.pokemonIndex.text = "5"
        subject.networkButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockViewModel.invoked(function: "makeCall", with: [subject, "5"]))
    }
    
    func testThatTouchingTheNetworkButtonWithoutSettingIndexHitsTheNetworkWithNothing() {
        _ = subject.view
        subject.networkButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockViewModel.invoked(function: "makeCall", with: [subject, ""]))
    }
    
    func testThatTheViewDelegateSetsTheLabel() {
        _ = subject.view
        subject.viewModel.pokemonName = "Pikachu"
        subject.pokemonIndex.text = "5"
        subject.networkButton.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockViewModel.invoked(function: "makeCall", with: [subject, "5"]))
        
        // TODO: Capture the first argument of makeCall and call onSuccess on it
        
        subject.onSuccess()
        XCTAssertEqual(subject.pokemonNameLabel.text, "Pikachu")
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
