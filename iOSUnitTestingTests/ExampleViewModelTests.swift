import Quick
import Nimble
import Moxie
@testable import iOSUnitTesting

class ExampleViewModelTests: QuickSpec {
    override func spec() {
        describe("ExampleViewModel") {
            var subject: ExampleViewModel!
            
            beforeEach {
                subject = ExampleViewModel()
            }
            
            afterEach{
                subject.requestor = Requestor.shared
            }
            
            describe("calculate") {
                
                it("doubles numbers") {
                    expect(subject.calculate(forNumber: 2)).to(equal(4))
                }
            }
            
            describe("makeCall") {
                let viewDelegate = MockViewDelegate()
                let mockRequestor = MockRequestor()
                
                beforeEach {
                    subject.requestor = mockRequestor
                }
                
                it("sets the view delegate") {
                    subject.makeCall(withDelegate:  viewDelegate, withPath: "5")
                    
                    expect(subject.viewDelegate).to(be(viewDelegate))
                }
                
                it("makes a request") {
                    subject.makeCall(withDelegate: viewDelegate, withPath: "5")
                    
                    expect(mockRequestor.invoked(function: "request", with: [subject, "5"])).to(beTrue())
                }
                
                it("calls the success callback") {
                    // TODO use argument captor to get callback
                    
                    let result = Pokemon()
                    result.name = "Charizard"
                    subject.viewDelegate = viewDelegate
                    
                    subject.onSuccess(result: result)
                    expect(subject.pokemonName).to(equal("Charizard"))
                    expect(viewDelegate.invoked(function: "onSuccess")).to(beTrue())
                }
            }
        }
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
