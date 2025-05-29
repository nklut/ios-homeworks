import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

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
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(galleryImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            galleryImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            galleryImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            galleryImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            galleryImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setup(with photo: Photo) {
        galleryImage.image = UIImage(named: photo.imageName)
    }

}
