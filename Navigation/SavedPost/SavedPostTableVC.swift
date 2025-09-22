import UIKit

class SavedPostTableVC: UITableViewController {
    
    weak var coordinator: SavedPostCoordinator?
    private let coreDataManager = CoreDataManager.shared
    
    private var savedPosts: [SavedPost] = CoreDataManager.shared.fetchPosts() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "eraser.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapDeleteAll)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedPosts = CoreDataManager.shared.fetchPosts()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var cfg = UIListContentConfiguration.cell()
        
        cfg.text = savedPosts[indexPath.row].postAuthor
        cfg.secondaryText = savedPosts[indexPath.row].postText

        cell.contentConfiguration = cfg

        return cell
    }

    @objc private func didTapDeleteAll() {
        coreDataManager.deleteAllPosts(posts: savedPosts)
        savedPosts = []
    }
    
}
