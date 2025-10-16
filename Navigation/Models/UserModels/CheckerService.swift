import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

enum userLoginStatus {
    case noData
    case emptyEmail
    case shortPassword
    case emailInUse
    case success
    case error(Error)
}

func signOutWithCompletion(completion: @escaping (Bool) -> Void) {
    do {
        try Auth.auth().signOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(true)
        }
    } catch {
        print("Sign out error: \(error.localizedDescription)")
        completion(false)
    }
}

protocol CheckerServiceProtocol {
    func checkCredentials(email userEmail: String, password userPassword: String) -> userLoginStatus
    func signUp(email userEmail: String, password userPassword: String)
}

final class CheckerService: CheckerServiceProtocol {
    
    func checkCredentials(email userEmail: String, password userPassword: String) -> userLoginStatus {
        
        var loginStatus: userLoginStatus = .noData
        
        if userEmail.isEmpty {
            return .emptyEmail
        }
        
        if userPassword.count < 6 {
            return .shortPassword
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { result, error in
            if let signInError = error {
                loginStatus = .error(signInError)
            } else {
                loginStatus = .success
            }
        }
        return loginStatus
    }
    
    func signUp(email userEmail: String, password userPassword: String) {
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { result, error in
            if let creationError = error {
                print(creationError.localizedDescription)
            }
        }
    }
}
