//
//  ImageCache.swift
//  FetchTakeHome
//
//  Created by Momo Khan on 5/30/25.
//

import UIKit

// TODO: - Set a size limit and evict if it gets larger than that

actor ImageCache {
    static let shared = ImageCache()
    
    private let cacheDirectory: URL
    
    init() {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        self.cacheDirectory = cachesURL.appendingPathComponent("ImageCache", isDirectory: true)
        
        do {
            try FileManager.default.createDirectory(at: self.cacheDirectory, withIntermediateDirectories: true)
            print("Successfully created directory")
        } catch {
            print("Failed to create directory \(error)")
        }
    }
    
    func cachePath(uuid: String) -> URL {
        let fileName = uuid + ".jpg"
        let path = cacheDirectory.appendingPathComponent(fileName)
        return path
    }
    
    func load(uuid: String) -> UIImage? {
        do {
            let data = try Data(contentsOf: cachePath(uuid: uuid))
            print("Successfully loaded file: \(uuid)")
            return UIImage(data: data)
        } catch {
            print("Failed to load from disk \(error)")
            return nil
        }
    }
    
    func save(image: UIImage, uuid: String) async {
        guard let data = image.jpegData(compressionQuality: 1.0) else {
            print("Problem generating data")
            return
        }
        do {
            try data.write(to: cachePath(uuid: uuid))
            print("Successfully saved filed \(uuid)")
        } catch {
            print("Failed to write to disk \(error)")
        }
    }
    
}
