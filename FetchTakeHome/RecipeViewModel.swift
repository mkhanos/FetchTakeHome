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
    @Published var error: Error?
    
    private let recipesService: RecipeService
    
    init(recipesService: RecipeService) {
        
        self.recipesService = recipesService
    }
    
    func loadRecipes() async {
        do {
            if let recipes = try await recipesService.fetchRecipes() {
                self.recipes = recipes
            }
        } catch {
            self.error = error
            print(error)
            
        }
    }
}
