//
//  JokeViewController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

// 3. Delegate Protocol implementation
// Here I conform my JokeViewController to the JokeControllerDelegate
class JokeViewController: UIViewController, JokeControllerDelegate {
    
    @IBOutlet weak var jokeImageView: UIImageView!
    @IBOutlet weak var jokeTextView: UITextView!
    
    // 5. Delegate Protocol implementation
    // I make an instance to the JokeController to be able to call the delegate variable
    let jokeController = JokeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // 6. Delegate Protocol implementation
        // I tell the JokeViewController that it itself is the delegate
        // I call my protocol function which executes my fetchJoke function from the JokeController
        jokeController.delegate = self
        testFetchMeme()
        
        
//        JokeController.fetchMeme { (meme) in
//            //
//        }
    }
    
    @IBAction func chuckMeButtonPressed(sender: AnyObject) {
        JokeController.fetchJoke { (joke) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let joke = joke {
                    self.jokeTextView.text = joke.joke
                }
            })
        }
        
        JokeController.fetchMeme { (meme) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let meme = meme else { return }
                ImageController.imageForURL(meme.imageEndpoint, completion: { (image) in
                    guard let image = image else { return }
                    self.jokeImageView.image = image
                })
            })
        }
    }
    
    // 4. Delegate Protocol implementation
    // I conform to the JokeControllerDelegate
    // Below I'm implementing my JokeController.fetchJoke func
    func testFetchMeme() {
        JokeController.fetchJoke { (joke) in
            //
        }
    }
    
}
