import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // Define spacing between photos and list of photos
    private let layoutSpacing = 8.0
    fileprivate lazy var photos: [UIImage] = Photo.make()
    fileprivate lazy var filteredPhotos: [UIImage] = []
    private let imageProcessor = ImageProcessor()
    

    // Create Gallery with user images and update View after image addition
//    private var imagesStorage = ImagePublisherFacade()
//    private var imagesGallery: [UIImage] = []
    
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
        
        // Setup Publisher for Gallery images
//        let delay = 0.5
//        let repeatCount = 20
//        let images = photos
//        setupPublisher(delay, repeatCount, images)
        
        // Setup filter options
        let filter: ColorFilter = .noir
        let sourceImages: [UIImage] = photos
        let qualityOfService: QualityOfService = .background
        
        #if DEBUG
        // QOS Perfomance testing
        let qualityOfServiceTestCases: [QualityOfService] = [.background, .default, .userInitiated, .userInteractive]
        applyFilterDebug(sourceImages, filter, qualityOfServiceTestCases)
        #else
        // Apply filter to photos
        applyFilter(sourceImages, filter, qualityOfService)
        #endif

        // Setup views and positions
        setupView()
        setupSubviews()
        setupConstraints()
    }
    
//    private func setupPublisher(_ delay: TimeInterval, _ repeatCount: Int, _ images: [UIImage]) {
//        
//        // Subscribe to publisher
//        imagesStorage.subscribe(self)
//        
//        // Add user images to the gallery. Using updated Photo Model
//        // addImagesWithTimer method is using "random pick" to get each picture from entire user gallery
//        imagesStorage.addImagesWithTimer(time: delay, repeat: repeatCount, userImages: images)
//        
//        // Remove subscription after time needed for gallery fulfilment
//        let timeToPublish: Double = delay * Double(repeatCount) + 2
//        DispatchQueue.main.asyncAfter(deadline: .now() + timeToPublish) {
//            self.imagesStorage.removeSubscription(for: self)
//        }
//    }
    
    private func applyFilter(_ sourceImages: [UIImage], _ filter: ColorFilter, _ qualityOfService: QualityOfService) {
        
        // Start processing
        imageProcessor.processImagesOnThread(sourceImages: sourceImages, filter: filter, qos: qualityOfService) {
            [weak self] filteredPhotos in guard let self else { return }
            
            // Convert CGImage back to UIImage
            let processedImages = filteredPhotos.compactMap { cgImage -> UIImage? in
                guard let cgImage = cgImage else { return nil }
                return UIImage(cgImage: cgImage)
            }
            
            // Relaod Collection on the main thread
            DispatchQueue.main.async {
                self.filteredPhotos = processedImages
                self.photoCollectionView.reloadData()
            }
        }
    }
    
    // Perfomance testing
    private func applyFilterDebug(_ sourceImages: [UIImage], _ filter: ColorFilter, _ qualityOfService: [QualityOfService]) {
        
        // Perfomance test for the list of different QAual
        for qos in qualityOfService {
            
            let startTime = CFAbsoluteTimeGetCurrent()
            
            // Start processing
            imageProcessor.processImagesOnThread(sourceImages: sourceImages, filter: filter, qos: qos) {
                [weak self] filteredPhotos in guard let self else { return }
                
                // Convert CGImage back to UIImage
                let processedImages = filteredPhotos.compactMap { cgImage -> UIImage? in
                    guard let cgImage = cgImage else { return nil }
                    return UIImage(cgImage: cgImage)
                }
                
                // Relaod Collection on the main thread
                DispatchQueue.main.async {
                    self.filteredPhotos = processedImages
                    self.photoCollectionView.reloadData()
                }
                
                let executionTime = CFAbsoluteTimeGetCurrent() - startTime
                print("Execution time for QualityOfService \(qos.rawValue) is: \(executionTime) seconds")
                
            }
        }

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
            photoCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
        
    // Amount of cells in section as amount of photos
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        filteredPhotos.count
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
        
        // Use Gallery image as Cell View Image
        let photo = filteredPhotos[indexPath.row]
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

//extension PhotosViewController: ImageLibrarySubscriber {
//    func receive(images: [UIImage]) {
//        // Add images to the Gallery
//        self.imagesGallery = images
//        photoCollectionView.reloadData()
//        
//        // Scroll to latest added image
//        let item = IndexPath(item: images.count - 1, section: 0)
//        photoCollectionView.scrollToItem(at: item, at: .bottom, animated: true)
//    }
//}
