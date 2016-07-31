//
//  JokeController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class JokeController {
    static let norrisBaseURL = NSURL(string: "https://api.chucknorris.io/jokes/random")
    
    static func fetchJoke(completion: (joke: Joke?) -> Void) {
        
        guard let url = norrisBaseURL else {
            print("Error: No URL Found")
            completion(joke: nil)
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding)  else {
                    print("Error: No Data found")
                    completion(joke: nil)
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else {
                print("Error: Unable to parse through JSON: \(responseDataString)")
                return
            }
            
            print("Success: \(responseDataString)")
            completion(joke: Joke(dictionary: jsonDictionary))
        }
    }
}
