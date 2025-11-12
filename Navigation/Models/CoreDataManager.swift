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
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
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
        print("Post with author \(postAuthor) and text \(postText[postText.startIndex...postText.index(postText.startIndex, offsetBy: 10)])")
        
        try? persistentContainer.viewContext.save()
    }
    
    func deletePost(post: SavedPost) {
        let context = post.managedObjectContext
        context?.delete(post)
        try? context?.save()
    }
//    
    func deleteAllPosts(posts: [SavedPost]) {
        // Debug feature
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedPost.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentContainer.viewContext
            
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Liked posts deleted")
        } catch {
            print("Deletion failed: \(error.localizedDescription)")
        }
    }
}
