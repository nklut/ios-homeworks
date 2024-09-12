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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        self.title = post.title
    }

}
