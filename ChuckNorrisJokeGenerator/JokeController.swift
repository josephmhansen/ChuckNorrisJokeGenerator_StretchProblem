//
//  JokeController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Joseph Hansen on 8/3/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class JokeController {
    
   
    
    static let baseURL = NSURL(string: "https://api.chucknorris.io/jokes")
    static let endpoint = JokeController.baseURL?.URLByAppendingPathComponent("random")
    
    static func getJoke(completion: (Joke: Joke?) -> Void) {
        
        guard let url = endpoint else {
            print("Error: no url found")
            completion(Joke: nil)
            return
        }
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data,
                let responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                  print("Error: no data found")
                    completion(Joke: nil)
                    return
            }
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else {
                print("Error: Issue serializing JSON \(responseDataString)")
                completion(Joke: nil)
                return
            }
           let joke = Joke(jsonDictionary: jsonDictionary)
            
            print("Success: Joke Created")
            completion(Joke: joke)
            
            }
        }
        
        
    }

