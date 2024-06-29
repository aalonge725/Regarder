//
//  FirebaseManager.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/26/24.
//

import Foundation
import Firebase

class FirebaseManager: ObservableObject {
    @Published var userIsLoggedIn = false
    @Published var userID: String?
    private var db = Firestore.firestore()
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
            }
        }
    }
    
    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                print("Error logging user in: \(error.localizedDescription)")
            }
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            userIsLoggedIn = false
            userID = nil
        } catch {
            print("Error logging user out: \(error.localizedDescription)")
        }
    }
    
    func fetchTitles(completion: @escaping ([Title]?, Error?) -> Void) {
        guard let userID = self.userID else {
            print("User ID is nil, unable to fetch titles")
            completion(nil, nil)
            return
        }
        
        let titlesCollection = db.collection("Titles").whereField("userID", isEqualTo: userID)
        
        titlesCollection.addSnapshotListener { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let snapshot = snapshot else {
                print("Snapshot is nil")
                completion(nil, nil)
                return
            }
            
            guard let userID = self.userID else {
                print("User ID is nil, unable to fetch titles from snapshot listener")
                completion(nil, nil)
                return
            }
            
            var titles: [Title] = []
            
            for document in snapshot.documents {
                let data = document.data()
                
                let id = data["id"] as? String ?? ""
                let title = data["title"] as? String ?? ""
                let type: TitleType = TitleType(rawValue: data["type"] as? String ?? "unknown") ?? .unknown
                let dateWatched = data["dateWatched"] as? String ?? ""
                let dateReleased = data["dateReleased"] as? String ?? ""
                let posterPicture = data["posterPicture"] as? String ?? ""
                let progress: TitleProgress = TitleProgress(rawValue: data["progress"] as? String ?? "Unspecified") ?? .unspecified
                
                let titleObject = Title(id: id, userID: userID, title: title, type: type, dateWatched: dateWatched, dateReleased: dateReleased, posterPicture: posterPicture, progress: progress)
                titles.append(titleObject)
            }
            
            completion(titles, nil)
        }
    }
    
    func addTitle(title: Title) {
        guard let userID = self.userID else {
            print("Invalid user ID, unable to add title")
            return
        }
        
        let ref = db.collection("Titles").document(title.title)
        
        ref.setData([
            "id": title.id,
            "userID": userID,
            "title": title.title,
            "type": title.type.rawValue,
            "dateWatched": title.dateWatched ?? "",
            "dateReleased": title.dateReleased,
            "posterPicture": title.posterPicture,
            "progress": title.progress.rawValue
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
