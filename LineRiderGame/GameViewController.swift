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
    var gameScene: GameScene?
    
    @IBOutlet var hideScrollView: UIButton!

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene")
        {
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene?
            {
                gameScene = sceneNode
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
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
        gameScene?.scrollView?.addSubview(hideScrollView)
        gameScene?.hideScrollViewButton = hideScrollView
        
        gameScene?.hideScrollViewButtonOriginalX = hideScrollView!.center.x
        gameScene?.hideScrollViewButtonOriginalY = hideScrollView!.center.y

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
        gameScene!.cleanUpLevel()
        //reset game state
    }
    
    @IBAction func showScrollView(_ sender: UIButton) {
        gameScene!.showScrollView()
    }

    
    @IBAction func hideScrollView(_ sender: UIButton) {
        gameScene!.hideScrollView()
    }
    
}







