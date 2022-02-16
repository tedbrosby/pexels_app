//
//  PhotosResource.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/16/22.
//

import Foundation

struct PhotosResource: APIResource {
    typealias ModelType = PhotosResult
    
    var methodPath: String {
        "/v1/search"
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "query", value: query)]
    }
    
    let query: String
    
    init(_ query: String) {
        self.query = query
    }
}
