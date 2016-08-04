//
//  JokeViewController.swift
//  ChuckNorrisJokeGenerator
//
//  Created by Diego Aguirre on 7/20/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var jokeTextView: UITextView!
    
    override func viewDidLoad() {
       
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        JokeController.getJoke { (Joke) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                guard let joke = Joke else { return }
                self.jokeTextView.text = joke.value
            })
            
        }
    }
}
