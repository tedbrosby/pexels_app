//
//  APIResource.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    var url: URLRequest {
        guard let apiKey = Bundle.main.infoDictionary?["APIKey"] as? String else {
            fatalError("Please insert an API key into the info.plist")
        }
        guard var components = URLComponents(string: "https://api.pexels.com/v1") else {
            fatalError("The API URL is incorrect")
        }
        components.path = methodPath
        if let queryItems = queryItems {
            components.queryItems = queryItems
        }
        guard let url = components.url else {
            fatalError("There was an error generating the URL")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("Basic " + apiKey, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
