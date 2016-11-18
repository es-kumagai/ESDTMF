import XCTest
@testable import ESDTMF

class ESDTMFTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ESDTMF().text, "Hello, World!")
    }


    static var allTests : [(String, (ESDTMFTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
