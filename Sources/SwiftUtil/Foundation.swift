import Foundation

public extension String {
    subscript(_ range: NSRange) -> Substring {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        return self[start..<end]
    }

    /// Adds spaces to camel case to make it look like a sentence
    ///
    /// "noteWillBeSaved".sentenceCase //"Note Will Be Saved"
    var sentenceCase: String {
        reduce(into: "") { (res, char) in
            if char.isUppercase { res.append(" ") }
            res.append(char)
        }.capitalized
    }
}
