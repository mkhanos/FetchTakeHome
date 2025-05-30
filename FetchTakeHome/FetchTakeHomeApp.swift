//
//  FetchTakeHomeApp.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import SwiftUI

@main
struct FetchTakeHomeApp: App {
    let recipesService = RecipeService()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: RecipeViewModel(recipesService: RecipeService()))
        }
    }
}
