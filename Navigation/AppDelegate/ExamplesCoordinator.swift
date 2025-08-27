import UIKit

final class ExamplesCoordinator: MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Current Example"
        navigationController.tabBarItem.image = UIImage(systemName: "document.circle")!
    }
    
    func start() {
        let exampleViewController = ExampleViewController()
        exampleViewController.coordinator = self
        navigationController.pushViewController(feedViewController, animated: true)
    }
}
