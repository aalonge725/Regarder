//
//  TitlesViewModel.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import Foundation

class TitlesViewModel: ObservableObject {
    @Published private var titles: [Title] = []
    private var firebaseManager: FirebaseManager? = nil
    
    func setFirebaseManager(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchTitles() {
        guard let firebaseManager = firebaseManager else {
            print("Error: firebase manager is nil during fetch")
            return
        }
        
        firebaseManager.fetchTitles { titles, error in
            if let error = error {
                print("Error fetching titles: \(error.localizedDescription)")
                return
            }
            
            if let titles = titles {
                self.titles = titles
            }
        }
    }
    
    func getTitles() -> [Title] {
        return self.titles
    }
    
    func addTitle(title: Title) {
        guard let firebaseManager = firebaseManager else {
            print("Error: firebase manager is nil")
            return
        }
        
        firebaseManager.addTitle(title: title)
    }
}
