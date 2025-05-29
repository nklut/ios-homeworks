struct Photo {
    let imageName: String
}

// List of Photos for the gallery
extension Photo {
    static func make() -> [Photo] {
        [
            Photo(imageName: "gallery1"),
            Photo(imageName: "gallery2"),
            Photo(imageName: "gallery3"),
            Photo(imageName: "gallery4"),
            Photo(imageName: "gallery5"),
            Photo(imageName: "gallery6"),
            Photo(imageName: "cat_news_1"),
            Photo(imageName: "cat_news_2"),
            Photo(imageName: "cat_news_3"),
            Photo(imageName: "cat_news_4"),
            Photo(imageName: "gallery1"),
            Photo(imageName: "gallery2"),
            Photo(imageName: "cat_news_1"),
            Photo(imageName: "cat_news_2"),
            Photo(imageName: "cat_news_3"),
            Photo(imageName: "cat_news_4"),
            Photo(imageName: "gallery3"),
            Photo(imageName: "gallery4"),
            Photo(imageName: "gallery5"),
            Photo(imageName: "gallery6"),
        ]
    }
}
