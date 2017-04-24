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
    
    var gameScene: GameScene?
    
    var scrollViewShowingToggle: Bool!
    
    @IBOutlet weak var congratulationsView: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        congratulationsView.layer.borderWidth = 1.0
        congratulationsView.layer.borderColor = UIColor.red.cgColor
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene")
        {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene?
            {
                gameScene = sceneNode
                gameScene!.viewController = self
                
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
        gameScene?.scrollView?.addSubview(menuBar)
        scrollViewShowingToggle = false
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
        self.view.addSubview(menuBar)
        //reset game state
    }
    
    @IBAction func scrollButtonTapped(_ sender: UIButton)
    {
        if scrollViewShowingToggle
        {
            self.view.addSubview(menuBar)
            gameScene!.hideScrollView()
        }
        
        if !scrollViewShowingToggle
        {
            self.gameScene?.scrollView?.addSubview(menuBar)
            gameScene!.showScrollView()
        }
    }

    @IBAction func drawButtonTapped(_ sender: UIButton)
    {
        self.view.addSubview(menuBar)
        gameScene!.hideScrollView()
    }

    @IBAction func nextLevel(_ sender: UIButton)
    {
        congratulationsView.isHidden = true
        gameScene!.cleanLevel = true
    }
    
    func showCompleteLevelView(score: Int) {
        scoreLabel.text = String(score)
        congratulationsView.isHidden = false
        
    }
}






