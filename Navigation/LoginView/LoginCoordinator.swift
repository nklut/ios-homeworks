import UIKit

protocol LoginDelegate: AnyObject {
    func didLogin()
}

final class LoginCoordinator: MainCoordinator {
    
    var navigationController: UINavigationController
    weak var delegate: LoginDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LogInViewController()
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func loginDone() {
        delegate?.didLogin()
    }
    
}
