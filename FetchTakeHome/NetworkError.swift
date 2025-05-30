//
//  NetworkError.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decoding(String)
    case noResponse
    case server(statusCode: Int)
    case unknown(Error)
}
