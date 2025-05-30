//
//  ContentView.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                ForEach(viewModel.recipes, id: \.uuid) { recipe in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)
                            Text(recipe.cuisine)
                                .font(.subheadline)
                        }
                        Spacer()
                        CachedImageView(url: URL(string: recipe.photo_url_small)!, uuid: recipe.uuid)
                            .frame(width: 100, height: 100)
                    }
                    .aspectRatio(16.0 / 9.0 , contentMode: .fit)
                }
            }
            .padding(.horizontal)
        }
        .refreshable {
            await viewModel.loadData()
        }
        .task {
            await viewModel.loadData()
        }
    }
    

}

#Preview {
    ContentView()
}
