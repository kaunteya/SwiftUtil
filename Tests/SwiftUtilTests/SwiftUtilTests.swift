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
}
