//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import SwiftUI

struct ContentView: View {
    @State var recipes: [Recipe] = []
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                ForEach(recipes, id: \.uuid) { recipe in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)
                            Text(recipe.cuisine)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .refreshable {
            await loadData()
        }
        .task {
            await loadData()
        }
    }
    
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

#Preview {
    ContentView(recipes: [])
}
