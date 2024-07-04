//
//  Title.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import Foundation

struct Title: Identifiable {
    let id: String
    var userID: String? = nil
    let title: String
    let type: TitleType
    var dateWatched: String?
    let dateReleased: String
    let posterPicture: String
    var progress: TitleProgress
    
    mutating func updateProgress(progress: TitleProgress) {
        self.progress = progress
    }
    
    mutating func setDateWatched(date: String) {
        self.dateWatched = date
    }
}

enum TitleType: String {
    case movie
    case series
    case unknown
}

enum TitleProgress: String, CaseIterable {
    static var allCases: [TitleProgress] {
        return [.watched, .watching, .notStarted]
    }
    
    case watched = "Watched"
    case watching = "In Progress"
    case notStarted = "Not Started"
    case unspecified = "Unspecified"
}
