//
//  CachedImagedView.swift
//  Country
//
//  Created by Bo Lin on 11/2/18.
//  Copyright © 2018 Bo Lin. All rights reserved.
//

import UIKit

class CachedImagedView: UIImageView {

    static let imageCache = NSCache<NSString, AnyObject>()
    
    private var urlStringForChecking: String?
    
    func loadImage(urlString: String, completion: (() -> ())? = nil) {
        image = nil
        
        self.urlStringForChecking = urlString
        let urlKey = urlString as NSString
        
        // check image existence in imageCache
        if let cachedImage = CachedImagedView.imageCache.object(forKey: urlKey) as? UIImage {
            image = cachedImage
            completion?()
            return
        }
        
        // download image
        if let url = URL(string: urlString) {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                if let imageData = urlContents, let image = UIImage(data: imageData) {
                    let urlString = "\(url)"
                    // save image to imageCache
                    CachedImagedView.imageCache.setObject(image, forKey: urlString as NSString)
                    // verify the urlString
                    if urlString == self?.urlStringForChecking  {
                        DispatchQueue.main.async {
                            self?.image = image
                            completion?()
                        }
                    }
                } else {
                    completion?()
                }
            }
        }
    }

}
