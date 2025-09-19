import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PostModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
            
        })
        
        return container
    }()
    
    func fetchPosts() -> [SavedPost] {
        
        let request = SavedPost.fetchRequest()
        return (try? persistentContainer.viewContext.fetch(request)) ?? []
        
    }
    
    func addPost(postAuthor: String, postText: String) {
        let likedPost = SavedPost(context: persistentContainer.viewContext)
        likedPost.postAuthor = postAuthor
        likedPost.postText = postText
        
        try? persistentContainer.viewContext.save()
    }
    
    func deletePost(){}

}
