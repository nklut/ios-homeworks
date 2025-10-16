
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct Event: Codable {
    // @DocumentID var id: String?
    var id: String?
    var title: String
    var description: String
    var author: String
    var date: Date
}


final class StoreManager {
    
    let db = Firestore.firestore().collection("events")
    
    func getEvents(completion: @escaping (([Event]?) -> Void)){
        
        db.getDocuments { querySnapshot, error in
            let result = querySnapshot?.documents.compactMap { document in
                return try? document.data(as: Event.self)
            }
            completion(result)
        }
    }
    
    func addEvent(){
        
    }
    
    func deleteEvent(){
        
    }
    
    func updateEvent(){
        
    }
}
