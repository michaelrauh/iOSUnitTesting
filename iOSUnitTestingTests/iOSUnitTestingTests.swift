import XCTest
import Moxie
@testable import iOSUnitTesting

class MockNavigator: Navigator, Mock {
    var moxie = Moxie()
    
    override func show(caller: UIViewController, destination: String) {
        record(function: "show", wasCalledWith: [caller, destination])
    }
}

class iOSUnitTestingTests: XCTestCase {
    var subject: ViewController!
    var mockNavigator: MockNavigator!
    
    override func setUp() {
        super.setUp()
        subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        mockNavigator = MockNavigator()
        subject.navigator = mockNavigator
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
}
