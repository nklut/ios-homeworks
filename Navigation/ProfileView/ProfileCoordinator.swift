import UIKit

final class ProfileCoordinator: MainCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Profile"
        navigationController.tabBarItem.image = UIImage(systemName: "person")!
    }
    
    func start() {
        
        #if DEBUG
            let user = TestUserService().testUser
        #else
            let user = CurentUserService().currentUser
        #endif
        
        let profileViewController = ProfileViewController(user: user)
        profileViewController.coordinator = self
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func setupNavigationController() {

    }
    
}

