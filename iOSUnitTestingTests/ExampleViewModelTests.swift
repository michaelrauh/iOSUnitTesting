import XCTest
@testable import iOSUnitTesting

class ExampleViewModelTests: XCTestCase {
    var subject: ExampleViewModel!
    override func setUp() {
        super.setUp()
        subject = ExampleViewModel()
    }
    
    func testThatCalculateDoublesNumbers() {
        XCTAssertEqual(subject.calculate(forNumber: 2), 4)
    }
}
