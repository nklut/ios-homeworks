import UIKit

class ExampleViewController: UIViewController {
    
    // Add coordinator
    weak var coordinator: ExamplesCoordinator?
    
    private var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StoreManager().getEvents { [weak self] events in
            guard let events else {
                return
            }
            self?.events = events
            
            print(self?.events ?? "No events")
            
        }
    }
}
