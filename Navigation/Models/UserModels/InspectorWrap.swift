final class InspectorWrap: LoginViewControllerDelegate {
    
    private var inspector = LoginInspector()
    
    func check(userLogin: String, userPass: String) -> Bool {
        return inspector.check(userLogin: userLogin, userPass: userPass)
    }
    
}
