import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    // Init table cell
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        // Setup basic style of cell
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }    
    
    // Cell design setup
    private func tuneView() {
        backgroundColor = UIColor(named: "profilePhotosCollectionBackground")
        contentView.backgroundColor = UIColor(named: "profilePhotosCollectionBackground")
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        contentMode = .scaleAspectFit
        accessoryType = .none
    }
    
    // Update and build the view for post view element
    func update(_ post: ProfilePost) {
        
        // Post Label == Author
        lazy var postLabelView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = post.author
            view.textColor = UIColor(named: "profileHeaderTextColor")
            view.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            view.numberOfLines = 2
            view.sizeToFit()
            
            return view
        }()
        
        // Post image
        lazy var postImage: UIImageView = {
            let view = UIImageView(image: UIImage(named: post.image))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
        
            return view
        } ()
        
        // Post main content
        lazy var postContentView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = post.description
            view.textColor = .systemGray
            view.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            view.numberOfLines = 0
            view.sizeToFit()
            
            return view
        }()
        
        // Post likes amount
        lazy var postLikesView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = String(format: "%@%d", "Likes: ", post.likes)
            view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            view.textColor = UIColor(named: "profileHeaderTextColor")
            view.sizeToFit()
            
            return view
        }()
        
        // Post views amount
        lazy var postViewsView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = String(format: "%@%d", "Views: ", post.views)
            view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            view.textColor = UIColor(named: "profileHeaderTextColor")
            view.sizeToFit()
            
            return view
        }()
        
        // Add post subviews to Cell content view
        func addSubviews() {
            postImage.clipsToBounds = true
            contentView.addSubview(postLabelView)
            contentView.addSubview(postImage)
            contentView.addSubview(postContentView)
            contentView.addSubview(postLikesView)
            contentView.addSubview(postViewsView)
        }
        
        // Setup positions of views inside content view
        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                
                // Setup Post Label position
                postLabelView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postLabelView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                postLabelView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
                postLabelView.heightAnchor.constraint(equalToConstant: 40),
                
                // Setup Post Image position
                postImage.topAnchor.constraint(equalTo: postLabelView.bottomAnchor, constant: 12),
                postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                
                // Setup Post Content position
                postContentView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
                postContentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postContentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                
                // Setup Post Likes counter position
                postLikesView.topAnchor.constraint(equalTo: postContentView.bottomAnchor),
                postLikesView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postLikesView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -150),
                postLikesView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
                
                // Setup Views Counter position
                postViewsView.heightAnchor.constraint(equalTo: postLikesView.heightAnchor),
                postViewsView.topAnchor.constraint(equalTo: postLikesView.topAnchor),
                postViewsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                postViewsView.bottomAnchor.constraint(equalTo: postLikesView.bottomAnchor)
            ])
        }
        
        addSubviews()
        setupConstraints()
    }
}
