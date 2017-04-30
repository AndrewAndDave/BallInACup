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
    @IBOutlet var starViewReferenceBox: UIView!

    var gameScene: GameScene!
    var levelManager: LevelManager!
    
    var totalStars: Int = 0
    var collectedStars: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {        
        let missingStars = totalStars - collectedStars
        var starX = 240
        
        if totalStars != 0
        {
            if collectedStars != 0
            {
                for _ in 1...collectedStars
                {
                    var imageView : UIImageView
                    imageView  = UIImageView(frame: CGRect(x: starX, y: 157, width: 66, height: 66))
                    imageView.image = UIImage(named:"Star")
                    self.view.addSubview(imageView)
                    
                    if (totalStars <= 3)
                    {
                        starX += 100
                    }
                    else
                    {
                        starX += 70
                    }
                }
                
                if missingStars != 0
                {
                    for _ in 1...missingStars
                    {
                        var imageView : UIImageView
                        imageView  = UIImageView(frame: CGRect(x: starX, y: 157, width: 66, height: 66))
                        imageView.image = UIImage(named:"Empty Star")
                        self.view.addSubview(imageView)
                    
                        if (totalStars <= 3)
                        {
                            starX += 100
                        }
                        else
                        {
                            starX += 70
                        }
                    }
                }
            }
            else
            {
                for _ in 1...totalStars
                {
                    var imageView : UIImageView
                    imageView  = UIImageView(frame: CGRect(x: starX, y: 157, width: 66, height: 66))
                    imageView.image = UIImage(named:"Empty Star")
                    self.view.addSubview(imageView)
                    
                    if (totalStars <= 3)
                    {
                        starX += 100
        
                    }
                    else
                    {
                        starX += 70
                    }
                }
            }
        }
        else
        {
            
        }
    }
    
    override func viewWillLayoutSubviews()
    {
        
    }
    
    @IBAction func nextLevel(_ sender: UIButton)
    {
        gameScene.currentLevel = levelManager.getNextLevel()
        gameScene.cleanUpLevel()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let point2 = touch?.location(in: self.view)
        
        print(point2!)
    }
}
