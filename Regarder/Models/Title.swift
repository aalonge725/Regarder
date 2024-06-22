//
//  Title.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/8/24.
//

import Foundation

struct Title: Identifiable {
    let id: String
    let title: String
    let isMovie: Bool
    let dateWatched: String?
    let dateReleased: String
    let posterPicture: String
    let progress: TitleProgress
}

enum TitleProgress: String, CaseIterable {
    static var allCases: [TitleProgress] {
        return [.watched, .watching, .notStarted]
    }
    
    case watched = "Watched"
    case watching = "In progress"
    case notStarted = "Not Started"
    case unspecified
}
