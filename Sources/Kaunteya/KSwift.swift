extension Array {
    /// This same as subscripting but would return optional if element not found
    func element(at index: Index) -> Element? {
        guard index < count else { return nil }
        return self[index]
    }
}

extension Collection {
    var isNotEmpty: Bool { !isEmpty }
    var secondLast: Element? { dropLast().last }
}

extension Substring {
    /// Can be used to convert SubString to String
    var toString: String {
        String(self)
    }
}
