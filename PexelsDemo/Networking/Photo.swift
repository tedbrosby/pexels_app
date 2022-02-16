//
//  Photo.swift
//  PexelsDemo
//
//  Created by ARMANDO RODRIGUEZ on 2/15/22.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photosResult = try? newJSONDecoder().decode(PhotosResult.self, from: jsonData)

import Foundation

// MARK: - PhotosResult
struct PhotosResult: Codable {
    let photos: [Photo]
    let nextPage: String
    let perPage, totalResults, page: Int

    enum CodingKeys: String, CodingKey {
        case photos
        case nextPage = "next_page"
        case perPage = "per_page"
        case totalResults = "total_results"
        case page
    }
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let photographer, avgColor: String
    let id: Int
    let photographerURL: String
    let width: Int
    let src: Src
    let alt: String
    let liked: Bool
    let photographerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case height, photographer
        case avgColor = "avg_color"
        case id
        case photographerURL = "photographer_url"
        case width, src, alt, liked
        case photographerID = "photographer_id"
        case url
    }
}

// MARK: - Src
struct Src: Codable {
    let medium, portrait, large, small: String
    let tiny, original, large2X, landscape: String

    enum CodingKeys: String, CodingKey {
        case medium, portrait, large, small, tiny, original
        case large2X = "large2x"
        case landscape
    }
}

