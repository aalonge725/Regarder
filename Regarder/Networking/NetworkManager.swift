//
//  NetworkManager.swift
//  Regarder
//
//  Created by Abraham Alonge on 6/14/24.
//

import Foundation

struct NetworkManager {
    static func get<T: Decodable>(url: URL, responseType: T.Type, urlSession: URLSession = .shared) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await urlSession.data(for: request)
        let response = try JSONDecoder().decode(responseType, from: data)
        
        return response
    }
}
