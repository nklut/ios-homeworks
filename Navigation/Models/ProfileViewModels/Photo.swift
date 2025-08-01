import UIKit
import iOSIntPackage

struct Photo {
    let image: UIImage
}

// List of Photos for the gallery
extension Photo {
    
    static func make() -> [UIImage] {
        var imagesList: [UIImage] = []
        let galleryList: [UIImage] = (1...6).map {UIImage(named: "gallery\($0)")!}
        let newsList: [UIImage] = (1...4).map {UIImage(named: "cat_news_\($0)")!}
        imagesList.append(contentsOf: newsList)
        imagesList.append(contentsOf: galleryList)
        imagesList.append(contentsOf: galleryList)
        imagesList.append(contentsOf: newsList)
        return imagesList
    }
}
