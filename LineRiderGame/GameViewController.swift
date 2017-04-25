//
//  GameViewController.swift
//  LineRiderGame
//
//  Created by Andrew Solesa on 2017-04-17.
//  Copyright © 2017 KSG. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController
{
    @IBOutlet var menuBar: UIView!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var drawButton: UIButton!
    @IBOutlet var resetLevelButton: UIButton!
    @IBOutlet var scrollButton: UIButton!
    @IBOutlet var hideMenuButton: UIButton!
    
    var gameScene: GameScene!
    var levelManager: LevelManager!
    var menuBarHidden: Bool!

    var scrollViewShowingToggle: Bool!
    
    var totalStars: Int = 0
    var collectedStars: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        levelManager = LevelManager()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene")
        {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene?
            {
                gameScene = sceneNode
                gameScene!.viewController = self
                gameScene.currentLevel = levelManager.currentLevel
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                //sceneNode.xScale
                
                // Present the scene
                if let view = self.view as! SKView?
                {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        scrollViewShowingToggle = false
        menuBarHidden = false
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        }
        else
        {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    @IBAction func playGame(_ sender: UIButton)
    {
        gameScene!.createBall(withImage: "ball")
    }
    
    @IBAction func resetLevel(_ sender: UIButton)
    {
        gameScene!.ballFlag = false
        gameScene!.cleanLevel = true
    }
    
    @IBAction func scrollButtonTapped(_ sender: UIButton)
    {
        gameScene!.showScrollView()
    }

    @IBAction func drawButtonTapped(_ sender: UIButton)
    {
        gameScene!.hideScrollView()
    }

    @IBAction func hideMenuButtonTapped(_ sender: UIButton)
    {
        if (menuBarHidden == false)
        {
            drawButton.isHidden = true
            resetLevelButton.isHidden = true
            scrollButton.isHidden = true
            
            menuBarHidden = true
            return
        }
        
        if (menuBarHidden == true)
        {
            drawButton.isHidden = false
            resetLevelButton.isHidden = false
            scrollButton.isHidden = false
            
            menuBarHidden = false
            return
        }
    }
    
    func completeLevel(totalStars: Int, collectedStars: Int)
    {
        self.totalStars = totalStars
        self.collectedStars = collectedStars
        
        performSegue(withIdentifier: "Level Complete", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "Level Complete")
        {
            let levelComplete = (segue.destination as! LevelCompleteViewController)
            
            levelComplete.gameScene = self.gameScene
            levelComplete.levelManager = self.levelManager
            levelComplete.totalStars = self.totalStars
            levelComplete.collectedStars = self.collectedStars
        }
    }
}






