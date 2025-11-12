import Foundation

final class PasswordBruteForce: PasswordBruteForcing {
    
    private var isCancelled = false
    private let characters: [Character] = {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let digits = "0123456789"
        let symbols = "!@#$%^&*()_+-=[]{}|;:,.<>?`~"
        return Array(letters + letters.lowercased() + digits + symbols)
    }()
    
    func generateRandomPassword(withLength length: Int = 4) -> String {
        var password = ""
        for _ in 0..<length {
            let randomIndex = Int.random(in: 0..<characters.count)
            let character = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
            password.append(character)
        }
        return password
    }
    
    func bruteForce(realPassword: String, completion: @escaping (String?) -> Void) {
        
        isCancelled = false
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            for length in 1...realPassword.count {
                if self.isCancelled { break }
                
                if let result = self.generateCombinations(
                    currentlength: length,
                    currentGuess: "",
                    realPassword: realPassword
                ) {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                    return
                }
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
       
       private func generateCombinations(currentlength: Int, currentGuess: String, realPassword: String) -> String? {
           if isCancelled {
               return nil
           }
           
           if currentGuess.count == currentlength {
               return currentGuess == realPassword ? currentGuess : nil
           }
           
           for char in characters {
               
               let newGuess = currentGuess + String(char)
               
               if let result = generateCombinations(
                currentlength: currentlength,
                currentGuess: newGuess,
                realPassword: realPassword,
               ) {
                   return result
               }
               if isCancelled { return nil }
           }

           return nil
       }
}
