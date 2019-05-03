//
//  CustomImageView.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

//Custom subclass of uiimageview particularly for loading image from a URL
class CustomImageView: UIImageView {
    var imageFromUrl: String?
    func loadImageFromUrl(urlStr: String){
        
        imageFromUrl = urlStr
        
        if let imageFROMcache = imageCache.object(forKey: urlStr as AnyObject) as? UIImage{
            self.image = imageFROMcache
            return
        }
    
    guard  let url = URL(string: urlStr) else {return}
    URLSession.shared.dataTask(with: url) { (data, response, error) in
    if error != nil{
    print(error!)
    return
    }
    DispatchQueue.main.async {
    
    guard let data = data else { return }
    
    guard let imageToCache = UIImage(data: data) else { return }
    
    if self.imageFromUrl == urlStr{
    
    self.image = imageToCache
    
    }
    imageCache.setObject(imageToCache, forKey: urlStr as AnyObject)
    
    }
    }.resume()
}
}


