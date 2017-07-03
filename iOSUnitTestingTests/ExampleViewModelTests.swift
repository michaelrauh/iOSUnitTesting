import XCTest
import Moxie
@testable import iOSUnitTesting

class ExampleViewModelTests: XCTestCase {
    var subject: ExampleViewModel!
    override func setUp() {
        super.setUp()
        subject = ExampleViewModel()
    }
    
    override func tearDown() {
        subject.requestor = Requestor.shared
    }
    
    func testThatCalculateDoublesNumbers() {
        XCTAssertEqual(subject.calculate(forNumber: 2), 4)
    }
    
    func testThatMakeCallSetsTheViewDelegate() {
        let viewDelegate = MockViewDelegate()
        subject.makeCall(withDelegate:  viewDelegate, withPath: "5")
        
        // TODO figure out how to compare the view delegate to itself
    }
    
    func testThatTheRequestIsMadeOnMakeCall() {
        let mockRequestor = MockRequestor()
        let viewDelegate = MockViewDelegate()
        
        subject.requestor = mockRequestor
        
        subject.makeCall(withDelegate: viewDelegate, withPath: "5")
        
        XCTAssertTrue(mockRequestor.invoked(function: "request", with: [subject, "5"]))
    }
    
    func testTheSuccessCallback() {
        // TODO: figure out how to capture the callback
        
        let mockViewDelegate = MockViewDelegate()
        let result = Pokemon()
        result.name = "Charizard"
        subject.viewDelegate = mockViewDelegate
        subject.onSuccess(result: result)
        XCTAssertEqual(subject.pokemonName, "Charizard")
        XCTAssertTrue(mockViewDelegate.invoked(function: "onSuccess"))
    }
}

class MockRequestor: RequestorProtocol, Mock {
    var moxie = Moxie()
    
    func request<T: ResponseDelegate>(withDelegate delegate: T, withPath path: String) {
        record(function: "request", wasCalledWith: [delegate, path])
    }
}

class MockViewDelegate: ViewDelegate, Mock {
    var moxie = Moxie()
    
    func onSuccess() {
        record(function: "onSuccess")
    }
}
