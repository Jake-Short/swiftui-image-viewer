import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(swiftui_image_viewerTests.allTests),
    ]
}
#endif
