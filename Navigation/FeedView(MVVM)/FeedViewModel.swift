final class FeedViewModel: FeedViewModelOutput {
    
    internal let secretWord: String = "correct"
    var guessStatus: Guess = .wrong
    
    func check(_ guessWord: String) -> Guess {
        secretWord == guessWord ? guessStatus = .correct : nil
        return guessStatus
    }
}
