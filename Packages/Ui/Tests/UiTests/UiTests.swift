import XCTest
@testable import Ui

final class UiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Ui().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
