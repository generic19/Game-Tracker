//
//  urls.swift
//  Game Tracker
//
//  Created by Basel Alasadi on 19/05/2025.
//
import Foundation

extension URL {
    func with(path: String? = nil, params: [String: String]) -> URL {
        let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        var url = self.appending(queryItems: queryItems)
        if let path = path {
            url = url.appending(path: path)
        }
        
        return url
    }
}
