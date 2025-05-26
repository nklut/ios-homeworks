import UIKit

class TableSectionFooterHeaderView: UITableViewHeaderFooterView {
    
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        profileHeader.translatesAutoresizingMaskIntoConstraints = false
        return profileHeader
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        contentView.addSubview(profileHeader)
    }
    
    func setupConstraints() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileHeader.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileHeader.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileHeader.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileHeader.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
