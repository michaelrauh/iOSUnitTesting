import Quick
import Nimble
import Moxie
@testable import iOSUnitTesting

class RequestorTests: QuickSpec {
    override func spec() {
        describe("Requestor") {
            let subject = Requestor.shared
            let mockResponseDelegate = MockResponseDelegate()
            
            context("When making a successful request") {
                
                it("passes the mapped object back up on success") {
                    let pokemon = Pokemon()
                    pokemon.name = "charmeleon"

                    subject.request(withDelegate: mockResponseDelegate, withPath: "5")

                    expect(mockResponseDelegate.invoked(function: "onSuccess", with: [pokemon])).toEventually(beTrue(), timeout: 5)

                }
            }
            
            context("When making an unsuccessful request") {
                
                it("calls the onfailure method") {
                    subject.request(withDelegate: mockResponseDelegate, withPath: "-1")

                    expect(mockResponseDelegate.invoked(function: "onFailure")).toEventually(beTrue(), timeout: 5)

                }
            }
        }
    }
}

class MockResponseDelegate: ResponseDelegate, Mock {
    var moxie = Moxie()
    typealias T = Pokemon
    
    func onSuccess (result: T?) {
        record(function: "onSuccess", wasCalledWith: [result!])
    }
    
    func onFailure(error: Error) {
        record(function: "onFailure")
    }
}
