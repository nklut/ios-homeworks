import UIKit

class PhotosViewController: UIViewController {
    
    // Define spacing between photos and list of photos
    private let layoutSpacing = 8.0
    fileprivate lazy var photos: [Photo] = Photo.make()
    
    // Create instance of collection view for the Photo Gallery
    private let photoCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        // Register collection cell ID
        view.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
        )
  
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup views and positions
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
    // Main view setup
    private func setupView() {
        title = "Photo Gallery"
        view.backgroundColor = .systemGray6
    }
    
    // Subviews setup
    private func setupSubviews() {
        view.addSubview(photoCollectionView)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
    
    // Positions setup
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            photoCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            photoCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
        ])
    }
}


extension PhotosViewController: UICollectionViewDataSource {
        
    // Amount of cells in section as amount of photos
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photos.count
    }
        
    // create and update cell using photo name from photoList
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath
        ) as! PhotosCollectionViewCell

        let photo = photos[indexPath.row]
        cell.setup(with: photo)
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    // image size calculations
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    // set image size
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: layoutSpacing)
        
        return CGSize(width: width, height: width)
    }
    
    // set Edge insets
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: layoutSpacing,
            left: layoutSpacing,
            bottom: layoutSpacing,
            right: layoutSpacing
        )
    }
    
    // set line spacing
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        layoutSpacing
    }
    
    // set item spasing
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        layoutSpacing
    }
}
