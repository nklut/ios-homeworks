import XCTest
//@testable import Navigation

enum GuessMock {
    case correct
    case wrong
}

final class FeedViewModelMock {
    private let secretWord: String = "correct"
    private(set) var guessStatus: GuessMock = .wrong
    
    func check(_ guessWord: String) -> GuessMock {
        secretWord == guessWord ? guessStatus = .correct : nil
        return guessStatus
    }
}

final class FeedViewModelTests: XCTestCase {
    
    var feed: FeedViewModelMock!
    
    override func setUp() {
        super.setUp()
        feed = FeedViewModelMock()
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        feed = nil
        try super.tearDownWithError()
    }

    func testCheckerCorrect() throws {
        // Expecting the correct result
        let result = feed.check("correct")
        XCTAssertEqual(result, .correct, "Should be .correct if user input is correct")
    }
    
    func testCheckerWrong() throws {
        // Expecting the wrong result
        let result = feed.check("Any other input except correct")
        XCTAssertEqual(result, .wrong, "Should be .wrong if user input is any than correct")
    }
    
    func testCheckerReplace() throws {
        // Testing word replace
        _ = feed.check("Any other input except correct")
        let result = feed.check("correct")
        XCTAssertEqual(result, .correct, "Should be .wrong if user input is any than correct")
    }
}
