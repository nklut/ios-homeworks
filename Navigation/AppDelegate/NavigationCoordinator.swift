import UIKit

final class NavigationCoordinator: MainCoordinator {
    
    var navigationController: UINavigationController
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
        self.window.rootViewController = navigationController
    }
    
    func start() {
        showLoginFlow()
    }
    
    private func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
    }
    
    private func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, window: window)
        tabBarCoordinator.start()
    }
}

extension NavigationCoordinator: LoginDelegate {
    func didLogin() {
        showMainFlow()
    }
}
