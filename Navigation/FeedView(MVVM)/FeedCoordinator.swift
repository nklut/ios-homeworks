import UIKit

final class FeedCoordinator: MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Feed"
        navigationController.tabBarItem.image = UIImage(systemName: "book.pages")!
    }
    
    func start() {
        let feedViewController = FeedViewController()
 //       let feedViewController = FeedTableViewController()
        feedViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: true)
    }
}
