import UIKit

class PostTableViewCell: UITableViewCell {
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }
        
    private func tuneView() {
        
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        
        accessoryView = nil
        accessoryType = .disclosureIndicator
        
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .systemGray
        selectedBackgroundView = selectedView
    }
    
    func update(_ model: profilePost) {
        textLabel?.text = model.author
        detailTextLabel?.text = model.description
        imageView?.image = UIImage(named: model.image)
    }
}
