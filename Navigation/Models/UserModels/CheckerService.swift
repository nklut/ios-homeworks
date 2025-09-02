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
        
        if userEmail.isEmpty {
            return .emptyEmail
        }
        
        if userPassword.count < 6 {
            return .shortPassword
        }
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword)
        
        print("User:")
        print(Auth.auth().currentUser?.email)
        
        if Auth.auth().currentUser != nil {
            return .success
        }
    
        return .noData
    }
    
    func signUp(email userEmail: String, password userPassword: String) {
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { authResult, error in
             
            if let error {
                let err = error as NSError
                print(err.localizedDescription)
            }
        }
    }
}
