import XCTest
@testable import Service

final class ServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Service().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
