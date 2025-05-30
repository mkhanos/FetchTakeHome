//
//  RecipeService.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]?
    
    func fetchEmpty() async throws -> [Recipe]?
    
    func fetchMalformed() async throws -> [Recipe]?
}

final class RecipeService {
    private var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchRecipes() async throws -> [Recipe]? {
        do {
            let response = try await networkClient.sendRequest(endpoint: RecipeEndpoints.recipes, response: RecipeResponse.self)
            return response.recipes
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
