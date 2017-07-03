protocol ResponseDelegate {
    associatedtype T
    func onSuccess (result: T) -> Void
    func onFailure(error: Error) -> Void
}

extension ResponseDelegate {
    func onFailure(error: Error) {
        print("PANIC")
        print(error)
    }
}
