
protocol LoginViewControllerDelegate: AnyObject {
    func check(userLogin: String, userPass: String) -> Bool
}
