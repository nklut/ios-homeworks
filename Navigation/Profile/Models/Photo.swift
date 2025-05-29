struct Photo {
    let imageName: String
}

extension Photo {
    static func make() -> [Photo] {
        [
            Photo(imageName: "cat_news_1"),
            Photo(imageName: "cat_news_2"),
            Photo(imageName: "cat_news_3"),
            Photo(imageName: "cat_news_4"),
            Photo(imageName: "cat_news_1"),
            Photo(imageName: "cat_news_2"),
            // MARK: - Fill up to 20 with new photos
            // Photo(imageName: "gallery1")
        ]
    }
}
