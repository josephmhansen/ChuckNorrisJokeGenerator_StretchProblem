//
//  Joke.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

struct Joke {
    private let kJoke = "value"
    
    let joke: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let joke = dictionary[kJoke] as? String else { return nil }
        
        self.joke = joke
    }
}