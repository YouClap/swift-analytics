import XCTest
@testable import swift_analytics

final class swift_analyticsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Analytics().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
