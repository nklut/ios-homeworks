import UIKit

class TestUserService: UserService {
    
    let testUser = User(
        userLogin: "DEBUG_Login",
        userFullName: "DEBUG_Name",
        userAvatar: UIImage(named: "cat")!,
        userStatus: "DEBUG_Status"
    )
    
    func chekUserLogin(_ userLogin: String) -> User? {
        //testUser.userLogin == userLogin ? testUser : nil
        testUser
    }
}
