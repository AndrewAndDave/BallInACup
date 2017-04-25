//
//  LevelCompletedViewController.swift
//  LineRiderGame
//
//  Created by David Guichon on 2017-04-22.
//  Copyright © 2017 KSG. All rights reserved.
//

import Foundation
import UIKit

class LevelCompleteViewController: UIViewController {
    
    @IBOutlet var congratulationsView: UIView!
    @IBOutlet var scoreLabel: UILabel!

    var totalStars: Int = 0
    var collectedStars: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {        
        let missingStars = totalStars - collectedStars
        var starX = 396.66
        
        if totalStars != 0
        {
            if collectedStars != 0
            {
                for _ in 1...collectedStars
                {
                    var imageView : UIImageView
                    imageView  = UIImageView(frame: CGRect(x: starX, y: 177, width: 20, height: 20))
                    imageView.image = UIImage(named:"Star")
                    self.view.addSubview(imageView)
                    
                    starX += 50
                }
                
                if missingStars != 0
                {
                    for _ in 1...missingStars
                    {
                        var imageView : UIImageView
                        imageView  = UIImageView(frame: CGRect(x: starX, y: 177, width: 20, height: 20))
                        imageView.image = UIImage(named:"Empty Star")
                        self.view.addSubview(imageView)
                    
                        starX += 50
                    }
                }
            }
            else
            {
                for _ in 1...totalStars
                {
                    var imageView : UIImageView
                    imageView  = UIImageView(frame: CGRect(x: starX, y: 177, width: 20, height: 20))
                    imageView.image = UIImage(named:"Empty Star")
                    self.view.addSubview(imageView)
                    
                    starX += 50
                }
            }
        }
        else
        {
            scoreLabel.text = "Total stars: NONE"
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        
    }
    
    @IBAction func nextLevel(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
