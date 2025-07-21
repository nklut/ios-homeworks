
class FeedModel {
    private let secretWord = "secret"
    
    func check(guessWord: String) -> Bool {
        return (secretWord == guessWord)
    }
}
