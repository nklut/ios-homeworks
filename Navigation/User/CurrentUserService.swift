class CurentUserService: UserService {
    
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func chekUserLogin(_ userLogin: String) -> User? {
        currentUser.userLogin == userLogin ? currentUser : nil
    }
}
