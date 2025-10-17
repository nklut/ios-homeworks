import UIKit

final class MapViewCoordinator: MainCoordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.tabBarItem.title = "Map"
        navigationController.tabBarItem.image = UIImage(systemName: "map.fill")!
    }
    
    func start() {
        let exampleViewController = MapViewController()
        exampleViewController.coordinator = self
        navigationController.pushViewController(exampleViewController, animated: true)
    }
}
