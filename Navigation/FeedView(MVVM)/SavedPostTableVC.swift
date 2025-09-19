import UIKit


class SavedPostTableVC: UITableViewController {
    
    private let coreDataManager = CoreDataManager.shared
    
    private var savedPosts: [SavedPost] = CoreDataManager.shared.fetchPosts() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

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
//
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        print(indexPath.row)
//    }

}
