import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // Init table cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        tuneView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: not implemented")
    }
    
    private func tuneView() {
        backgroundColor = UIColor(named: "profilePhotosCollectionBackground")
        contentView.backgroundColor = UIColor(named: "profilePhotosCollectionBackground")
        textLabel?.backgroundColor = .clear
        detailTextLabel?.backgroundColor = .clear
        imageView?.backgroundColor = .clear
        contentMode = .scaleAspectFit
        accessoryType = .none
    }
    
    func update() {
        let pictureSize = (contentView.bounds.size.width + 24) / 4.0
        
        lazy var imagesView: UIView = {
            let view = UIView()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor(named: "profilePhotosCollectionBackground")
            
            return view
            
        }()
        
        lazy var lableView: UILabel = {
            let view  = UILabel()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.text = "Photos"
            view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            view.textColor = UIColor(named: "profileHeaderTextColor")
            
            return view
        }()
        
        lazy var arrow: UILabel = {
            let view = UILabel()
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.text = "→"
            view.font = UIFont.systemFont(ofSize: 24)
            
            return view
        }()
        
        lazy var image1: UIImageView = {
            let view = UIImageView(image: UIImage(named: "cat_news_1"))
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            
            return view
        }()
        
        lazy var image2: UIImageView = {
            let view = UIImageView(image: UIImage(named: "cat_news_2"))
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            
            return view
        }()
        
        lazy var image3: UIImageView = {
            let view = UIImageView(image: UIImage(named: "cat_news_3"))
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            
            return view
        }()
        
        lazy var image4: UIImageView = {
            let view = UIImageView(image: UIImage(named: "cat_news_4"))
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = 6
            view.clipsToBounds = true
            
            return view
        }()
        
        
        func addSubviews() {
            
            contentView.addSubview(lableView)
            contentView.addSubview(arrow)
            imagesView.addSubview(image1)
            imagesView.addSubview(image2)
            imagesView.addSubview(image3)
            imagesView.addSubview(image4)
            contentView.addSubview(imagesView)
        }
        
       func setupConstrains() {
           
           let safeArea = contentView.safeAreaLayoutGuide
           
            NSLayoutConstraint.activate([
                
                lableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
                lableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
                lableView.widthAnchor.constraint(equalToConstant: 150),
                //lableView.heightAnchor.constraint(equalToConstant: 24),

                arrow.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
                arrow.centerYAnchor.constraint(equalTo: lableView.centerYAnchor),
                arrow.heightAnchor.constraint(equalToConstant: 24),
                arrow.widthAnchor.constraint(equalToConstant: 24),
                
                imagesView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
                imagesView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
                imagesView.topAnchor.constraint(equalTo: lableView.bottomAnchor),
                imagesView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
                imagesView.heightAnchor.constraint(equalToConstant: pictureSize + 24.0),

                image1.topAnchor.constraint(equalTo: imagesView.topAnchor, constant: 12),
                image1.leadingAnchor.constraint(equalTo: imagesView.leadingAnchor, constant: 12),
                image1.heightAnchor.constraint(equalToConstant: pictureSize),
                image1.widthAnchor.constraint(equalToConstant: pictureSize),

                image2.topAnchor.constraint(equalTo: image1.topAnchor),
                image2.leadingAnchor.constraint(equalTo: image1.trailingAnchor, constant: 8),
                image2.heightAnchor.constraint(equalToConstant: pictureSize),
                image2.widthAnchor.constraint(equalToConstant: pictureSize),

                image3.topAnchor.constraint(equalTo: image1.topAnchor),
                image3.leadingAnchor.constraint(equalTo: image2.trailingAnchor, constant: 8),
                image3.heightAnchor.constraint(equalToConstant: pictureSize),
                image3.widthAnchor.constraint(equalToConstant: pictureSize),

                image4.topAnchor.constraint(equalTo: image1.topAnchor),
                image4.leadingAnchor.constraint(equalTo: image3.trailingAnchor, constant: 8),
                image4.heightAnchor.constraint(equalToConstant: pictureSize),
                image4.widthAnchor.constraint(equalToConstant: pictureSize),
            
            ])
        }
        
        addSubviews()
        setupConstrains()
    }
}
