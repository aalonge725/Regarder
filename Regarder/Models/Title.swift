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
    let dateReleased: Date
    let posterPicture: String
    let progress: TitleProgress
}

enum TitleProgress {
    case watched
    case watching
    case notStarted
}
