import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        tuneView()

    }
    private func tuneView() {
        
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        contentMode = .scaleAspectFit
        accessoryType = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }
    
    func update(_ post: profilePost) {
        lazy var postLabelView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = post.author
            view.textColor = .black
            view.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            view.numberOfLines = 2
            view.sizeToFit()
            
            return view
        }()
        
        lazy var postImage: UIImageView = {
            let view = UIImageView(image: UIImage(named: post.image))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .black
        
            return view
        } ()
        
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
        
        lazy var postLikesView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = String(format: "%@%d", "Likes: ", post.likes)
            view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            view.textColor = .black
            view.sizeToFit()
            
            return view
        }()
        lazy var postViewsView: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            
            view.text = String(format: "%@%d", "Views: ", post.views)
            view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
            view.textColor = .black
            view.sizeToFit()
            
            return view
        }()
        
        
        func setupConstraints() {
            
            let safeArea = contentView.safeAreaLayoutGuide
            
            NSLayoutConstraint.activate([
                postLabelView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postLabelView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
                postLabelView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            ])
            
            NSLayoutConstraint.activate([
                postImage.topAnchor.constraint(equalTo: postLabelView.bottomAnchor, constant: 12),
                postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                postImage.heightAnchor.constraint(equalTo: contentView.widthAnchor),
                postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor)
            ])
            
            NSLayoutConstraint.activate([
                postContentView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 16),
                postContentView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postContentView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            ])
            
            NSLayoutConstraint.activate([
                postLikesView.topAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -16),
                postLikesView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                postLikesView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -150),
            ])
            
            NSLayoutConstraint.activate([
                postViewsView.topAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -16),
                postViewsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            ])
            

        }
        postImage.clipsToBounds = true
        contentView.addSubview(postLabelView)
        contentView.addSubview(postImage)
        contentView.addSubview(postContentView)
        contentView.addSubview(postLikesView)
        contentView.addSubview(postViewsView)
        setupConstraints()
    }

    

    

        
//    func update(_ model: profilePost) {
//        let view = UIView()
//        

//        

//        
//        func setupConstraints() {
//            
//            let safeArea = contentView.safeAreaLayoutGuide
//            
//            NSLayoutConstraint.activate([
//                view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//                view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//                view.topAnchor.constraint(equalTo: contentView.topAnchor),
//                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//            ])
//

////            NSLayoutConstraint.activate([
////                postLabelView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
////                postLabelView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
////                postLabelView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
////                postLabelView.heightAnchor.constraint(equalToConstant: 20)
////            ])
//        }
//        
//        view.addSubview(postLabelView)
//        view.addSubview(postImage)
//        setupConstraints()
//        
//        
//        
//        contentView.addSubview(view)
//    }
}
