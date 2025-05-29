import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    // Define and setup image view
    private lazy var galleryImage: UIImageView = {
        let view = UIImageView(frame: .zero)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    } ()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // setup main view
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        // add and setup subviews
        addSubviews()
        setupConstraints()
    }
    
    // Add subview
    private func addSubviews() {
        contentView.addSubview(galleryImage)
    }
    
    // Position subview
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            galleryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // setup image by image name in photos list
    func setup(with photo: Photo) {
        galleryImage.image = UIImage(named: photo.imageName)
    }

}
