import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .systemGray3
        
        view.addSubview(profileHeaderView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
        ])
        
    }
    
}

