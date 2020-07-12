import XCTest
@testable import SwiftUtil

final class SwiftUtilTests: XCTestCase {
    func testStringsentenceCase() {
        XCTAssertEqual("noteWillBeSaved".sentenceCase, "Note Will Be Saved")
        XCTAssertEqual("note".sentenceCase, "Note")
    }

    func testClamping() {
        XCTAssertEqual(70.clamped(to: 50...100), 70)

        XCTAssertEqual(49.clamped(to: 50...100), 50)
        XCTAssertEqual(50.clamped(to: 50...100), 50)
        XCTAssertEqual(51.clamped(to: 50...100), 51)

        XCTAssertEqual(99.clamped(to: 50...100), 99)
        XCTAssertEqual(100.clamped(to: 50...100), 100)
        XCTAssertEqual(101.clamped(to: 50...100), 100)
    }

    func testDateFormatting() {
        let date = Date(timeIntervalSince1970: 1589822634)
        XCTAssertEqual(date.string(DateFormatter("d MMM yyyy")), "18 May 2020")
        XCTAssertEqual(date.string(format: "d MM yyyy"), "18 05 2020")
    }

    func testStringisEmpty() {
        XCTAssertEqual("kaunteya".ifEmpty("Nana"), "kaunteya")
        XCTAssertEqual("".ifEmpty("Nana"), "Nana")
    }

    func testAllOccurencesOfSubString() {
        let basicString = "Some text is large and some is larger than other"
        XCTAssertEqual(basicString.allOccurences(of: "is"), [10, 28])
        XCTAssertEqual(basicString.allOccurences(of: "large"), [13, 31])
        XCTAssertEqual(basicString.allOccurences(of: "larger"), [31])

        let caseString = "Some text is large and some is Larger than other. Large"
        XCTAssertEqual(caseString.allOccurences(of: "large", caseSensitive: false), [13, 31, 50])
        XCTAssertEqual(caseString.allOccurences(of: "large", caseSensitive: true), [13])
        XCTAssertEqual(caseString.allOccurences(of: "Large", caseSensitive: true), [31, 50])

        let emojiString = "Some 😎ext is large and som🌸 is Larger than other. Large"
        XCTAssertEqual(emojiString.allOccurences(of: "large", caseSensitive: false), [13, 31, 50])
        XCTAssertEqual(emojiString.allOccurences(of: "large", caseSensitive: true), [13])
        XCTAssertEqual(emojiString.allOccurences(of: "Large", caseSensitive: true), [31, 50])

        let longText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequAt.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
        XCTAssertEqual(longText.allOccurences(of: "at"), [169, 280, 316, 329, 356, 364, 366])
        XCTAssertEqual(longText.allOccurences(of: "At"), [228])
        XCTAssertEqual(longText.allOccurences(of: "At", caseSensitive: false), [169, 228, 280, 316, 329, 356, 364, 366])
    }
}
