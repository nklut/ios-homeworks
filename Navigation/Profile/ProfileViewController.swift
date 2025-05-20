import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Add Set Status Button
    private lazy var setTitleButton: UIButton = {
        // Declaration
        let view = UIButton(type: .roundedRect)
        view.setTitle("Set title", for: .normal)
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        
        // Functions
        view.addTarget(self, action: #selector(didPressStatusButton), for: .touchUpInside)
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile"
        view.backgroundColor = .systemGray3
        
        view.addSubview(profileHeaderView)
        view.addSubview(setTitleButton)
        
        setupConstraints()
    }
    
    // Change Title on button press
    @objc func didPressStatusButton() {
        title = profileHeaderView.statusTextField.text
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
            setTitleButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            setTitleButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            setTitleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}
