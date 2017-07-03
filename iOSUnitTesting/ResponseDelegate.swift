import ObjectMapper

protocol ResponseDelegate {
    associatedtype T: Mappable
    func onSuccess (result: T?) -> Void
    func onFailure(error: Error) -> Void
}

extension ResponseDelegate {
    func onFailure(error: Error) {
        print("PANIC")
        print(error)
    }
}
