import UIKit

class ProfileViewController: UIViewController {
    
    // Adding main View
    private lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
            
        return view
        }()
    
    // Add alert notification whe "Change Status" button was pressed
    @objc func alertOnStatusButton() {
        // Create Status Changed Alert
        let alert = UIAlertController(
            title: "Status changed to: ",
            message: profileHeader.statusText,
            preferredStyle: .alert
        )
        
        // Reset Status text field after showing alert
        func resetStatusChange(action: UIAlertAction) {
            profileHeader.statusTextField.endEditing(true)
            profileHeader.statusTextField.text = ""

        }
        
        // Set alert Action
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: resetStatusChange))
        
        // Show Alert
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // View setup
        title = "Profile"
        self.view.backgroundColor = .systemBackground
        
        // Add alert to "Change Status" button
        profileHeader.statusButton.addTarget(
            self,
            action: #selector(alertOnStatusButton),
            for: .touchUpInside
        )
        
        // Show view
        view.addSubview(profileHeader)
        viewWillLayoutSubviews()
        setupContraints()
    }
    
    private func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
            
        NSLayoutConstraint.activate([
            profileHeader.leadingAnchor.constraint(
                equalTo: safeAreaGuide.leadingAnchor,
                constant: 0.0
            ),
            profileHeader.trailingAnchor.constraint(
                equalTo: safeAreaGuide.trailingAnchor,
                constant: 0.0
            ),
            profileHeader.topAnchor.constraint(
                equalTo: safeAreaGuide.topAnchor,
                constant: 0.0
            ),
            profileHeader.bottomAnchor.constraint(
                equalTo: safeAreaGuide.bottomAnchor,
                constant: 0.0
            )
        ])
    }
}
