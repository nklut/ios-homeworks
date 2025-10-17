import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    weak var coordinator: ProfileCoordinator?
    
    // List of sample Posts(4 items)
    fileprivate let data = postList
    private var sectionsList = ["Photos", "Posts"]
    private let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Declare table for posts
    private lazy var tableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        #if DEBUG
        view.backgroundColor = .systemPink
        #endif
        
        return view
    }()
    
    // IDs for base cells
    private enum CellReuseID: String {
        case post = "PostTableViewCell_ReuseID"
        case photo = "PhotosTableViewCell_ReuseID"
    }
    
    // IDs for Headers and Footers of cells
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show tab bar again(was hidden on logo screen) and hide "Back" button
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Setup design, add subviews and main view, setup positions
        setupView()
        addSubviews()
        setupConstraints()
        setupTableView()        
    }
    
    // Table handler
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.indexPathsForSelectedRows?.forEach{ indexPath in
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }

    // Basic main design
    private func setupView() {
        view.backgroundColor = .systemGray6
        #if DEBUG
        view.backgroundColor = .systemPink
        #endif
    }
    
    // Add table subview
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    // Setup table position
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        
        // Initial table setup
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 700
        if #available(iOS 15.0, *)  {
            tableView.sectionHeaderTopPadding = 0
        }
        
        // Register table cell types IDs
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )
        
        tableView.register(
            PhotosTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photo.rawValue
        )
        
        tableView.register(
            TableSectionFooterHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        // Init behaviour
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// Table Data setup
extension ProfileViewController: UITableViewDataSource {
    
    // Define Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsList.count
    }
    
    // Define Number of cells in 1 section equal to the Amount of posts in postList
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return postList.count
        } else {
            return 1
        }
    }

    // Add post to cell according to index(Path)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1
        {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.post.rawValue,
                for: indexPath
            ) as? PostTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
        
            cell.update(postList[indexPath.row])
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photo.rawValue,
                for: indexPath
            ) as? PhotosTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }
            cell.update()
            return cell
        }
    }
}

// Table delegate setup
extension ProfileViewController: UITableViewDelegate {
    
    // Define header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }

    // Set header as Profile Header View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: HeaderFooterReuseID.base.rawValue
            ) as? TableSectionFooterHeaderView else {
                fatalError("could not dequeueReusableCell")
            }
            headerView.user = user
            return headerView
        
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
