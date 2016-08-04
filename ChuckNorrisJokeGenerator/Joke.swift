//
//  Joke.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Joseph Hansen on 8/3/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Joke {
    
    private let kValue = "value"
    let value: String
    
    init?(jsonDictionary: [String: AnyObject]){
        guard let value = jsonDictionary[kValue] as? String else {return nil }
        self.value = value
    }
    
}
