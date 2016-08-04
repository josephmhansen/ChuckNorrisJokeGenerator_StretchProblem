//
//  JokeController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Joseph Hansen on 8/4/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class JokeController{

    static let baseURL = NSURL(string: "https://api.chucknorris.io/jokes/random")
    
    static func getJoke(completion: (joke: Joke?) -> Void) {
        guard let url = JokeController.baseURL else {
            print("error: No url found")
            completion(joke: nil)
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                let responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: no data found")
                    completion(joke: nil)
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else {
                print("error: issue serializing JSON \(responseDataString)")
                completion(joke: nil)
                return
            }
            
            print("Success!")
            completion(joke: Joke(jsonDictionary: jsonDictionary))
        }
        
    }
    
}