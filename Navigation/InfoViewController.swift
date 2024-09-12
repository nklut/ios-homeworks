import UIKit

class InfoViewController: UIViewController {
    
    // Show allert Button setup
    private var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete post", for: .normal)
        return button
    }()
    
    
    // Show Alert on button press
    @objc func didPressButton() {
        // Create Alert object
        let alert = UIAlertController(
            title: "Delete",
            message: "If you delete this post, it will no longer be available",
            preferredStyle: .alert
        )
        
        // Print used action to console
        func consolePrint(action: UIAlertAction) {
            print(action.title!)
        }
        
        // Set couple alert Actions
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: consolePrint))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: consolePrint))
        
        // Show Alert
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        self.title = "Info"
        
        // Add and setup button
        view.addSubview(button)
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }

}
