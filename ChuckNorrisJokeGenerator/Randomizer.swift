//
//  Randomizer.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

extension Array {
    
    func randomIndex() -> Element {
        let random = Int(arc4random_uniform(UInt32(self.count)))
        return self[random]
    }
}