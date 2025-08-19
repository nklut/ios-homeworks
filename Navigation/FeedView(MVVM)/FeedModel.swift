protocol FeedViewModelOutput {
    var secretWord: String { get }
    var guessStatus: Guess { get set }
    func check(_ guessWord: String) -> Guess
}

enum Guess {
    case correct
    case wrong
}
