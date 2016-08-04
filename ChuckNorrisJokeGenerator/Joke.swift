//
//  Joke.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Joseph Hansen on 8/4/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Joke {
    
    private let kValue = "value"
    
    let value: String
    
    init?(jsonDictionary: [String: AnyObject]) {
        guard let joke = jsonDictionary[kValue] as? String else { return nil }
        self.value = joke
    }
}
