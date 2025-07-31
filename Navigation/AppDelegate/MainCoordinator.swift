import UIKit

protocol MainCoordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
