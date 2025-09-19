import UIKit


class FeedTableViewController: UITableViewController {
    
    // Add coordinator
    weak var coordinator: FeedCoordinator?
    private let coreDataManager = CoreDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var cnfg = UIListContentConfiguration.cell()
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        
        cnfg.text = postList[indexPath.row].author
        cnfg.secondaryText = postList[indexPath.row].description
        
        doubleTapGesture.numberOfTapsRequired = 2
    
        cell.selectionStyle = .none
        cell.contentConfiguration = cnfg
        cell.addGestureRecognizer(doubleTapGesture)

        return cell
    }
        
    @objc private func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        
        guard let tappedCell = gesture.view as? UITableViewCell else { return }
        
        if let content = tappedCell.contentConfiguration as? UIListContentConfiguration {
            let author: String = content.text ?? "Unknown author"
            let text: String = content.secondaryText ?? "Post text is absent"
            
            //coreDataManager.addPost(author: author, text: text)
            
            // Debug
           // print(coreDataManager.fetchPosts())
        }
    }
}
