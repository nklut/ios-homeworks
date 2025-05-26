import UIKit

class TableSectionFooterHeaderView: UITableViewHeaderFooterView {

    // MARK: - Subviews
//    
//    private lazy var profileHeader: ProfileHeaderView = {
//        let view = ProfileHeaderView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        return view
//    }()
    
    private lazy var profileHeader: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.font = UIFont.preferredFont(forTextStyle: .footnote)
            
            return label
        }()

    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        tuneView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     //MARK: - Public

    func update(title: String) {
       profileHeader.text = title
    }
    
    // MARK: - Private
    
    private func tuneView() {
        contentView.backgroundColor = .red
    }
    
    private func addSubviews() {
        contentView.addSubview(profileHeader)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeader.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 0.0
            ),
            profileHeader.trailingAnchor.constraint(
                equalTo:contentView.trailingAnchor
            ),
            profileHeader.heightAnchor.constraint(
                equalToConstant: 230.0
            ),
            profileHeader.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
        ])
    }
}
