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

    /// Alternate string if the source string is empty
    func ifEmpty(_ str: String) -> String {
        self.isNotEmpty ? self : str
    }

    var toInt: Int? {
        Int(self)
    }

    func allOccurences(of subString: String, caseSensitive: Bool = true) -> [Int] {
        let subString = caseSensitive ? subString : subString.lowercased()
        let mainString = caseSensitive ? self : self.lowercased()
        var indices = [Int]()
        var searchStartIndex = mainString.startIndex
        while searchStartIndex < mainString.endIndex,
            let range = mainString.range(of: subString, range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: mainString.startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}
