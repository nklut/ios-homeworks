struct Photo {
    let imageName: String
}

// List of Photos for the gallery
extension Photo {
    
    static func make() -> [Photo] {
        var galleryList = (1...6).map {Photo(imageName: "gallery\($0)")}
        let newsList = (1...4).map {Photo(imageName: "cat_news_\($0)")}
        galleryList.append(contentsOf: newsList)
        galleryList.append(contentsOf: galleryList)
        galleryList.append(contentsOf: newsList)
        return galleryList
    }
}
