
class Checker {
    
//    static let shared: Checker = {
//        let instance = Checker()
//        return instance
//    }()
    
    static let shared = Checker()
    
    private init() {}
    
    #if DEBUG
        private let login = "123"
        private let password = "123"
    #else
        private let login = "login"
        private let password = "pass"
    #endif
    
    func check(userLogin: String, userPass: String) -> Bool {
        return (userLogin == login) && (userPass == password)
    }
}

