import XCTest
@testable import iOSUnitTesting

class iOSUnitTestingTests: XCTestCase {
    var subject: ViewController!
    
    override func setUp() {
        super.setUp()
        subject = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController
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
}
