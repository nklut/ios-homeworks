import UIKit

class TabBarCoordinator: MainCoordinator {
    
    var navigationController: UINavigationController
    private let window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
        
    }
    
    func start() {
        
        let tabBarController = UITabBarController()
        let feedCoordinator = FeedCoordinator(navigationController: UINavigationController())
        let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
        let examplesCoordinator = ExamplesCoordinator(navigationController: UINavigationController())
         
        profileCoordinator.start()
        feedCoordinator.start()
        examplesCoordinator.start()
        
        tabBarController.viewControllers = [
            profileCoordinator.navigationController,
            feedCoordinator.navigationController,
            examplesCoordinator.navigationController
        ]
        
        tabBarController.tabBar.isHidden = false
        window.rootViewController = tabBarController
    }
    
    
}
