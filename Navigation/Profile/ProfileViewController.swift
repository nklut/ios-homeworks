import UIKit

class ProfileViewController: UIViewController {
    
    fileprivate let data = postList

    private lazy var tableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private enum CellReuseID: String {
        case post = "PostTableViewCell_ReuseID"
    }
    
    private enum HeaderFooterReuseID: String {
        case base = "TableSectionFooterHeaderView_ReuseID"
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        setupView()
        addSubviews()
        setupConstraints()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.indexPathsForSelectedRows?.forEach{ indexPath in
            tableView.deselectRow(at: indexPath, animated: animated)
        }
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        
        // TODO !!!!!
        //tableView.rowHeight = UITableView.automaticDimension
        tableView.rowHeight = 800
        tableView.estimatedRowHeight = 800.0
        

        // TODO
        let headerView = ProfileHeaderView()
        tableView.setAndLayout(headerView: headerView)
        tableView.setAndLayout(headerView: UIView())
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )
        
        tableView.register(
            TableSectionFooterHeaderView.self,
            forHeaderFooterViewReuseIdentifier: HeaderFooterReuseID.base.rawValue
        )
        
        tableView.dataSource = self
        //tableView.delegate = self
        
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        postList.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.post.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(postList[indexPath.row])
        
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }

//    func tableView(
//        _ tableView: UITableView,
//        viewForHeaderInSection section: Int
//    ) -> UIView? {
//
//        guard let headerView = tableView.dequeueReusableHeaderFooterView(
//            withIdentifier: CellReuseID.post.rawValue
//        ) as? TableSectionFooterHeaderView else {
//            fatalError("could not dequeueReusableCell")
//        }
//
//        headerView.update(title: "TESTTTTTTT")
//
//        return headerView
//    }

 }


// func tableView(
//        _ tableView: UITableView,
//        didSelectRowAt indexPath: IndexPath
//    ) {
//        print("Did select cell at \(indexPath)")
//        let nextViewController = LanguageDetailsViewController()
//
//        let model = data[indexPath.row]
//        nextViewController.update(model: model)
//
//        navigationController?.pushViewController(
//            nextViewController,
//            animated: true
//        )
//    }

//    func tableView(
//        _ tableView: UITableView,
//        viewForFooterInSection section: Int
//    ) -> UIView? {
//
//        guard let footerView = tableView.dequeueReusableHeaderFooterView(
//            withIdentifier: HeaderFooterReuseID.base.rawValue
//        ) as? TableSectionFooterHeaderView else {
//            fatalError("could not dequeueReusableCell")
//        }
//
//        footerView.update(title: DateProvider.currentTime)
//
//        return footerView
//    }

// }
