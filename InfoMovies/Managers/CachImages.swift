//
//  CachImages.swift
//  InfoMovies
//
//  Created by Robin Singh on 13/04/21.
//

import Foundation
import UIKit

class CachImages {
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    
    func getImage(for imdbId: String) -> UIImage?{
        if let image = imageCache.object(forKey: imdbId as NSString) {
            return image
        }
        return nil
    }
    
    func insertImage(_ image: UIImage,for imdbId: String){
        imageCache.setObject(image, forKey: imdbId as NSString)
    }
    
    func removeImage(for imdbId: String) {
        imageCache.removeObject(forKey: imdbId as NSString)
    }
    
    func removeAllImages() {
        imageCache.removeAllObjects()
    }
    
}
