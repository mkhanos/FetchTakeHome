//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: RecipeViewModel
    
    init(viewModel: RecipeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                ForEach(viewModel.recipes, id: \.uuid) { recipe in
                    RecipeRow(recipe: recipe)
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            await viewModel.loadRecipes()
        }
        .task {
            await viewModel.loadRecipes()
        }
    }
    

}
