//
//  MemeController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/31/16.
//  Copyright © 2016 home. All rights reserved.
//

import Foundation

class MemeController {
    static let memeBaseURL = NSURL(string: "https://api.imgflip.com/get_memes")
    
    static func fetchMeme(completion: (meme: [Meme])-> Void) {
        guard let memeURL = memeBaseURL else {
            print("Error: No URL found")
            completion(meme: [])
            return
        }
        
        NetworkController.performRequestForURL(memeURL, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data found")
                    completion(meme: [])
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject],
                dataDictionary = jsonDictionary["data"] as? [String: AnyObject] else {
                    print("No Json found: \(responseDataString)")
                    completion(meme: [])
                    return
            }
            
            guard let memeDictionaryArray = dataDictionary["memes"] as? [[String: AnyObject]] else {
                print("Error: No Parsing Failed for key 'memes'")
                completion(meme: [])
                return
            }
            
            let memeArray = memeDictionaryArray.flatMap {Meme(dictionary: $0)}
            completion(meme: memeArray)
        }
    }
}