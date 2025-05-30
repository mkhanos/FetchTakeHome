//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

struct Recipe: Codable {
    let cuisine: String
    let name: String
    let photo_url_large: String
    let photo_url_small: String
    let source_url: String?
    let uuid: String
    let youtube_url: String?
}
