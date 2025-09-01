import UIKit

class ExamplesViewController: UIViewController {
    
    // Add coordinator
    weak var coordinator: ExamplesCoordinator?
    
    private var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //fireBaseExample()
        
    }
    
    private func fireBaseExample() {
        
        StoreManager().getEvents { [weak self] events in
            guard let events else {
                return
            }
            self?.events = events
            print(self?.events ?? "No events")
            
        }
    }
}
