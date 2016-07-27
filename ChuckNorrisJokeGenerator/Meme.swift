//
//  Meme.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

struct Meme {
    private let kImage = "url"
    
    let imageEndpoint: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let imageEndpoint = dictionary[kImage] as? String else { return nil }
        
        self.imageEndpoint = imageEndpoint
    }
    
    init(imageString: String) {
        self.imageEndpoint = imageString
    }
}