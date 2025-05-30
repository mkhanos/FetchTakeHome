//
//  ImageLoader.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import Foundation
import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func load(url: URL, uuid: String) async {
        Task {
            if let cached = await ImageCache.shared.load(uuid: uuid) {
                self.image = cached
                return
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    self.image = image
                    await ImageCache.shared.save(image: image, uuid: uuid)
                }
            } catch {
                print("Failed to load image \(error)")
            }
        }
    }
}
