import XCTest
@testable import SwiftUtil

final class SwiftUtilTests: XCTestCase {
    func testStringsentenceCase() {
        XCTAssertEqual("noteWillBeSaved".sentenceCase, "Note Will Be Saved")
        XCTAssertEqual("note".sentenceCase, "Note")
    }
}
