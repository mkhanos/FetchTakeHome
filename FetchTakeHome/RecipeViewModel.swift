//
//  RecipeViewModel.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func loadData() async {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        do {
            // TODO: - Abstract network later
            let (data, _) = try await URLSession.shared.data(from: url)
            let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
            self.recipes = recipeResponse.recipes
        } catch {
            // TODO: - handle network failure
            print("Failed")
        }
    }
}
