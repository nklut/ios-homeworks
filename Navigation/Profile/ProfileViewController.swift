import UIKit

class ProfileViewController: UIViewController {

    private lazy var postTableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        // TODO TEST COLOR
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // TODO
    private enum CellReuseID: String {
        case base = "Base_ReuseID"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        
        setupConstraints()
        
        setupTableView()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        postTable.indexPathForSelectedRow?.forEach{ indexPath in
//            postTable.deselectRow(at: indexPath, animated: animated)
//        }
//    }

    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(postTableView)
    }
    
    private func setupTableView() {
        
        postTableView.rowHeight = UITableView.automaticDimension
        postTableView.estimatedRowHeight = 220.0

        // TODO
        let headerView = ProfileHeaderView()
        postTableView.setAndLayout(headerView: headerView)
        
    }

    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            postTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            postTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            postTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            postTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
}
