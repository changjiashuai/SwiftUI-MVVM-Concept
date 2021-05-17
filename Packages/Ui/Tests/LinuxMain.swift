import XCTest

import UiTests

var tests = [XCTestCaseEntry]()
tests += UiTests.allTests()
XCTMain(tests)
