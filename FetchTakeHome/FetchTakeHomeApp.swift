//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let networkClient: NetworkClient = NetworkClient()
    let recipesService: RecipeService
    let recipeViewModel: RecipeViewModel
    
    init() {
        recipesService = RecipeService(networkClient: networkClient)
        recipeViewModel = RecipeViewModel(recipesService: recipesService)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: recipeViewModel)
        }
    }
}
