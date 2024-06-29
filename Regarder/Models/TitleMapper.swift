//
//  TitleMapper.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/24/24.
//

import Foundation

struct TitleMapper {
    static func titleFromOMDbAPI(title: OMDbAPITitle, progress: TitleProgress, dateWatched: String?) -> Title {
        var type = TitleType.unknown
        
        if title.type == .movie {
            type = .movie
        } else if title.type == .series {
            type = .series
        }
        
        return Title(id: title.id,
                     title: title.title,
                     type: type,
                     dateWatched: dateWatched,
                     dateReleased: title.year,
                     posterPicture: title.poster,
                     progress: progress)
    }
}
