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
    static let memeBaseURL = NSURL(string: "https://api.imgflip.com/get_memes")
    
//    init() {
//        JokeController.fetchMeme { (meme) in
//            //
//        }
//    }
    
    // 2. Delegate Protocol implementation
    // I create a weak variable to the delegate itself of type JokeControllerDelegate?
    weak var delegate: JokeControllerDelegate?
    
    static func fetchJoke(completion: (joke: Joke?) -> Void) {
        
        guard let url = norrisBaseURL else { return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data,
            responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding)  else {
                print("Error: No Data found")
                completion(joke: nil)
                return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else { return }
            
            print("Success: \(responseDataString)")
            completion(joke: Joke(dictionary: jsonDictionary))
        }
    }
    
    static func fetchMeme(completion: (meme: Meme?)-> Void) {
        guard let memeURL = memeBaseURL else {
            print("Error: No URL found")
            return
        }
    
        NetworkController.performRequestForURL(memeURL, httpMethod: .Get) { (data, error) in
            guard let data = data,
                responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) else {
                    print("Error: No Data found")
                    completion(meme: nil)
                    return
            }
            
            guard let jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject],
            dataDictionary = jsonDictionary["data"] as? [String: AnyObject] else {
                 print("No Json found: \(responseDataString)")
                    completion(meme: nil)
                    return
            }
            
            guard let memeDictionaryArray = dataDictionary["memes"] as? [[String: AnyObject]] else {
                print("Error: no memeDictionaryArray")
                completion(meme: nil)
                return
            }
            
            for memeDictionary in memeDictionaryArray {
                guard let imageDictionary = memeDictionary["url"] as? String else {
                    print("Error: no Meme dictionary")
                    return
                }
                
                print("Successful: Completion")
                print(imageDictionary)
                completion(meme: Meme(imageString: imageDictionary))
            }
        }
    }
}

// 1. Delegate Protocol implementation
// The Following protocol is not part of the original project
// I'm creating this protocol to fire off my fetchJoke function from the JokeController upon the loading of the JokeViewController
// Here i'm creating a JokeControllerDelegate that is implemented on the class with a simple func
protocol JokeControllerDelegate: class {
    func testFetchMeme()
}