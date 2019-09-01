//
//  AsyncImageView.swift
//  Sample
//
//  Created by zwtin on 2019/07/18.
//  Copyright © 2019 zwtin. All rights reserved.
//

import UIKit
import Alamofire

class AsyncImageView: UIImageView {
    static let cache = NSCache<AnyObject, AnyObject>()
        
    func loadImage(from urlString: String) {
        
        if let image = AsyncImageView.cache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = image
        } else {
            Alamofire.request(urlString)
                .response(completionHandler: { [weak self] response in
                    guard let image = UIImage(data: response.data ?? Data()) else {
                        return
                    }
                    AsyncImageView.cache.setObject(image, forKey: urlString as AnyObject)
                    self?.image = image
                })
        }
    }
    
}
