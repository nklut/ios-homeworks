import UIKit

class FeedViewController: UIViewController {
    
    // Button
    private var button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Open Post", for: .normal)
        return button
    }()
    
    // Open Post Controller on press
    @objc func didPressButton() {
        let currentPost = Post(title: "Post_1")
        let pvc = PostViewController(post: currentPost)
        self.navigationController?.pushViewController(pvc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Add Button to Feed View
        self.view.addSubview(button)
        
        // Button style and setup
        self.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)

    }

}
