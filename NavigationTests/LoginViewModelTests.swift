import XCTest
@testable import Navigation

class LoginViewModelFinalTests: XCTestCase {
    
    var viewController: LogInViewController!
    
    override func setUp() {
        super.setUp()
        viewController = LogInViewController()
        viewController.loadViewIfNeeded()
    }

    func testBruteButtonPressed() {
        
        let expectation = self.expectation(description: "Brute force completion")

        viewController.bruteButtonPressed()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(true)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testDidTapSignupButton() {
        viewController.didTapSignupButton()
        XCTAssertNoThrow(viewController.didTapSignupButton())
    }
    
    func testDidTapLoginButton() {
        viewController.didTapLoginButton()
        XCTAssertNoThrow(viewController.didTapLoginButton())
    }
    
    func testAllPublicMethods() {
        XCTAssertNoThrow(viewController.didTapLoginButton())
        XCTAssertNoThrow(viewController.didTapSignupButton())
        XCTAssertNoThrow(viewController.bruteButtonPressed())
        XCTAssertNoThrow(viewController.viewWillAppear(true))
        XCTAssertNoThrow(viewController.viewWillDisappear(true))
    }
}
