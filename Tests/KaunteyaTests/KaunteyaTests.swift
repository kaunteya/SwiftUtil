import XCTest
@testable import Kaunteya

final class KaunteyaTests: XCTestCase {
    func testSecondLastArray() {
        XCTAssertEqual([1, 2].secondLast, 1)
        XCTAssertEqual([1, 2, 3].secondLast, 2)
        XCTAssertNil([1].secondLast)
        XCTAssertNil([Int]().secondLast)
    }
}
