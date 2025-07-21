import UIKit

class User {
    let userLogin: String
    let userFullName: String
    let userAvatar: UIImage
    let userStatus: String
    
    init(userLogin: String, userFullName: String, userAvatar: UIImage, userStatus: String) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}



