import XCTest
@testable import GithubUI

final class GithubUITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(GithubUI().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
