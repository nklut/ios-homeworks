import UIKit

class CurentUserService: UserService {
    
    let currentUser = User(
        userLogin: "correctLogin",
        userFullName: "Don Caton",
        userAvatar: UIImage(named: "cat")!,
        userStatus: "Don Caton is sleeping"
    )
    
    func chekUserLogin(_ userLogin: String) -> User? {
        //currentUser.userLogin == userLogin ? currentUser : nil
        currentUser
    }
}
