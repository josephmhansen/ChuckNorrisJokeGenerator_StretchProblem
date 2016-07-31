//
//  JokeViewController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeImageView: UIImageView!
    @IBOutlet weak var jokeTextView: UITextView!
    
    let jokeController = JokeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func chuckMeButtonPressed(sender: AnyObject) {
        JokeController.fetchJoke { (joke) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let joke = joke {
                    self.jokeTextView.text = joke.joke
                }
            })
        }
        
        MemeController.fetchMeme { (memes) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                
                ImageController.imageForURL(memes.randomIndex().imageEndpoint, completion: { (image) in
                    guard let image = image else { return }
                    self.jokeImageView.image = image
                })
            })
        }
    }
}
