//
//  OMDbAPISearchResult.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/18/24.
//

import Foundation

struct OMDbAPISearchResult: Codable {
    let titles: [OMDbAPITitle]
    let resultCount: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case titles = "Search"
        case resultCount = "totalResults"
        case response = "Response"
    }
}

struct OMDbAPITitle: Identifiable, Codable {
    let id: String
    let title: String
    let year: String
    let type: OMDbAPITitleType
    let poster: String
    
    enum OMDbAPITitleType: String, Codable {
        case movie, series, episode, unknown
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = OMDbAPITitleType(rawValue: rawValue) ?? .unknown
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "imdbID"
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}
