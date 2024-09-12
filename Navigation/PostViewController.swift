import UIKit

struct Post {
    let title: String
}

class PostViewController: UIViewController {
    
    var post: Post
    
    // Setup post init
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Open Info Button setup
    private var infoButton: UIButton = {
        let button = UIButton(type: .infoLight)
        button.setTitle("", for: .normal)
        return button
    }()
    
    // Open Info on press
    @objc func didPressButton() {
        let ivc = InfoViewController()
        self.navigationController?.pushViewController(ivc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        self.title = post.title
        
        // Adding Button to the Navigation Bar
        infoButton.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        self.navigationItem.setRightBarButton(UIBarButtonItem(customView: infoButton), animated: true)
    }
}
