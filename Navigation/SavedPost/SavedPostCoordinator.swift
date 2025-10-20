import UIKit

final class SavedPostCoordinator: MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Liked posts"
        navigationController.tabBarItem.image = UIImage(systemName: "heart.text.clipboard.fill")!
    }
    
    func start() {
        let savedPostVC = SavedPostTableVC()
        savedPostVC.coordinator = self
        navigationController.pushViewController(savedPostVC, animated: true)
    }
}
