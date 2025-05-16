import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeader: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
            
        return view
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        self.view.backgroundColor = .systemBackground
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




