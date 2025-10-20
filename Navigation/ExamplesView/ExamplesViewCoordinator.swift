import UIKit

final class ExamplesCoordinator: MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Current Lesson Example"
        navigationController.tabBarItem.image = UIImage(systemName: "document.circle")!
    }
    
    func start() {
        let exampleViewController = ExamplesViewController()
        exampleViewController.coordinator = self
        navigationController.pushViewController(exampleViewController, animated: true)
    }
}
