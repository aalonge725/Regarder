//
//  TitleMapper.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/24/24.
//

import Foundation

struct TitleMapper {
    static func titleFromOMDbAPI(title: OMDbAPITitle, progress: TitleProgress, dateWatched: String?) -> Title {
        return Title(id: title.id,
                     title: title.title,
                     isMovie: title.type == .movie,
                     dateWatched: dateWatched,
                     dateReleased: title.year,
                     posterPicture: title.poster,
                     progress: progress)
    }
}
