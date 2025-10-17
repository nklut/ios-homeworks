
final class LoginInspector: LoginViewControllerDelegate {
    func check(userLogin: String, userPass: String) -> Bool {
        return Checker.shared.check(userLogin: userLogin, userPass: userPass)
    }
}
