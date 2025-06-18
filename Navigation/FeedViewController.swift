import UIKit

class FeedViewController: UIViewController {
    
    // Add button for Post 1
    private lazy var openPostButton1: UIButton = {
        // Declararion
        let view = UIButton(type: .roundedRect)
        view.setTitle("Open Post 1", for: .normal)
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemBlue
        
        // Function
        view.addTarget(self, action: #selector(openPost1), for: .touchUpInside)
        
        return view
    }()
    
    // Add button for Post 2
    private lazy var openPostButton2: UIButton = {
        // Declararion
        let view = UIButton(type: .roundedRect)
        view.setTitle("Open Post 2", for: .normal)
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemBlue
        
        // Function
        view.addTarget(self, action: #selector(openPost2), for: .touchUpInside)
        
        return view
    }()
    
    // Add stack view for an Open Post buttons
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        // Setup
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        // Design
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10.0
        view.axis = .vertical
        
        // Add buttons
        view.addArrangedSubview(self.openPostButton1)
        view.addArrangedSubview(self.openPostButton2)
        
        return view
    }()
    
    // Open post 1 for button 1
    @objc func openPost1() {
        let currentPost = Post(title: "Post 1")
        let pvc = PostViewController(post: currentPost)
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
    // Open post 2 for button 2
    @objc func openPost2() {
        let currentPost = Post(title: "Post 2")
        let pvc = PostViewController(post: currentPost)
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
    override func viewDidLoad() {
        // Setup main view
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        
        // Add Stacked buttons to Feed View
        view.addSubview(stackView)
        
        // Positioning
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
