//
//  RecipeService.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

final class RecipeService {
    func fetchRecipes() async -> [Recipe]? {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        do {
            // TODO: - Abstract network later
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            return recipeResponse.recipes
        } catch {
            // TODO: - handle network failure
            print("Failed")
            return []
        }
    }
}
