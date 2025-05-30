//
//  NetworkClient.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

protocol NetworkClientProtocol {
    func sendRequest<T: Decodable>(endpoint: APIEndpoint, response: T.Type) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private var session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func sendRequest<T: Decodable>(endpoint: APIEndpoint, response: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint.buildRequest())
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                throw URLError(.badServerResponse)
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let decodingError as DecodingError {
                switch decodingError {
                case .keyNotFound(let key, let context):
                    throw NetworkError.decoding(
                        "Missing key: \(key.stringValue) – \(context.debugDescription)"
                    )
                case .typeMismatch(_, let context),
                        .valueNotFound(_, let context),
                        .dataCorrupted(let context):
                    throw NetworkError.decoding(
                        "Decoding error: \(context.debugDescription)"
                    )
                }
            } catch {
                throw NetworkError.unknown(error)
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
