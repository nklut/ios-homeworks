import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //fileprivate let data = postList

    private lazy var tableView: UITableView = {
        let view = UITableView.init(
            frame: .zero,
            style: .plain
        )
        
        // TODO TEST COLOR
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
//    private enum CellReuseID: String {
//        case post = "Post_ReuseID"
//    }
    
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
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 220.0
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }

        // TODO
        //let headerView = ProfileHeaderView()
        //tableView.setAndLayout(headerView: headerView)
        tableView.setAndLayout(headerView: UIView())
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.post.rawValue
        )
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
}

//extension ViewController: UITableViewDataSource {
    
//    func numberOfSections(
//        in tableView: UITableView
//    ) -> Int {
//        1
//    }
//    
//    func tableView(
//        _ tableView: UITableView,
//        numberOfRowsInSection section: Int
//    ) -> Int {
//        postList.count
//    }
//
//    func tableView(
//        _ tableView: UITableView,
//        cellForRowAt indexPath: IndexPath
//    ) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(
//            withIdentifier: CellReuseID.post.rawValue,
//            for: indexPath
//        ) as? PostTableViewCell else {
//            fatalError("could not dequeueReusableCell")
//        }
//        
//        cell.update(postList[indexPath.row])
//        
//        return cell
//    }
//}

//extension ViewController: UITableViewDelegate {
//    
//    func tableView(
//        _ tableView: UITableView,
//        heightForHeaderInSection section: Int
//    ) -> CGFloat {
//        UITableView.automaticDimension
//    }
//
//    func tableView(
//        _ tableView: UITableView,
//        heightForFooterInSection section: Int
//    ) -> CGFloat {
//        UITableView.automaticDimension
//    }
//    
////    func tableView(
////        _ tableView: UITableView,
////        viewForHeaderInSection section: Int
////    ) -> UIView? {
////
////        guard let headerView = tableView.dequeueReusableHeaderFooterView(
////            withIdentifier: HeaderFooterReuseID.base.rawValue
////        ) as? Pos else {
////            fatalError("could not dequeueReusableCell")
////        }
////
////        headerView.update(title: "Пример работы с UITableViewDelegate")
////
////        return headerView
////    }
//
////    func tableView(
////        _ tableView: UITableView,
////        viewForFooterInSection section: Int
////    ) -> UIView? {
////
////        guard let footerView = tableView.dequeueReusableHeaderFooterView(
////            withIdentifier: HeaderFooterReuseID.base.rawValue
////        ) as? TableSectionFooterHeaderView else {
////            fatalError("could not dequeueReusableCell")
////        }
////
////        footerView.update(title: DateProvider.currentTime)
////
////        return footerView
////    }
//    
////    func tableView(
////        _ tableView: UITableView,
////        didSelectRowAt indexPath: IndexPath
////    ) {
////        print("Did select cell at \(indexPath)")
////        let nextViewController = LanguageDetailsViewController()
////        
////        let model = data[indexPath.row]
////        nextViewController.update(model: model)
////        
////        navigationController?.pushViewController(
////            nextViewController,
////            animated: true
////        )
////    }
//}
