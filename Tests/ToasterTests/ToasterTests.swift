@testable import Toaster
import XCTest

struct TestToast: ToastType {
    typealias ViewProvider = TestToastViewProvider
    var duration: ToastDuration
}

class TestToastView: UIView {
}

struct TestToastViewProvider: ToastViewProvider {
    func viewForToast(toast: TestToast) -> UIView {
        return TestToastView()
    }
    typealias Toaste = TestToast
}

final class ToasterTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let center = ToastCenter()
        center.register(toastType: TestToast.self, with: TestToastViewProvider())
        let provider = center.toastViewProvider(for: TestToast.self)
        XCTAssert(provider != nil)
        let view = provider?.viewForToast(toast: TestToast(duration: .default))
        XCTAssert(view is TestToastView)
    }

}
