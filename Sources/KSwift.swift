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

extension String {
    subscript(_ range: NSRange) -> Substring {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return self[start..<end]
    }
}
