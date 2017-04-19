//
//  GameScene.swift
//  LineRiderGame
//
//  Created by Andrew Solesa on 2017-04-17.
//  Copyright © 2017 KSG. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit




//basketImage POSITION, backBoard POSITION, basket POSITION, bottomBasket POSITION,

class GameScene: SKScene, UIScrollViewDelegate
{
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    

    var mutablePath: CGMutablePath!
    var splineShapeNode: SKShapeNode!

    
    var ballFlag: Bool = false
    var level: Int = 0
    
    var scrollView: UIScrollView?
    
    var spawnImage: SKShapeNode?
        var spawnImageNodeOriginalX: CGFloat?
        var spawnImageNodeOriginalY: CGFloat?
    
    var basketImage: SKShapeNode?
        var basketImageNodeOriginalX: CGFloat?
        var basketImageNodeOriginalY: CGFloat?
    
    var backBoard: SKShapeNode?
        var backBoardNodeOriginalX: CGFloat?
        var backBoardNodeOriginalY: CGFloat?
    
    var basket: SKShapeNode?
        var basketNodeOriginalX: CGFloat?
        var basketNodeOriginalY: CGFloat?
    
    var bottomBasket: SKShapeNode?
        var bottomBasketNodeOriginalX: CGFloat?
        var bottomBasketNodeOriginalY: CGFloat?
    
    var ball: SKShapeNode?
    
    var hideScrollViewButton: UIButton?
        var hideScrollViewButtonOriginalX: CGFloat?
        var hideScrollViewButtonOriginalY: CGFloat?
    
    var arrayOfLines = [SKShapeNode]()
        var linesOriginalXArray = [CGFloat]()
        var linesOriginalYArray = [CGFloat]()
    
    var arrayOfStars = [SKShapeNode]()
        var starsOriginalXArray = [CGFloat]()
        var starsOriginalYArray = [CGFloat]()
    
    override func didMove(to view: SKView)
    {
        /* Setup your scene here */
        self.createLevel(levelNumber: level)
        
    }
    
    override func willMove(from view: SKView) {
        scrollView = nil
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        adjustContent(scrollView: scrollView)
    }
    
    func adjustContent(scrollView: UIScrollView) {
        print("\(scrollView.contentOffset.x) \(scrollView.contentOffset.y)")
        
        //COULD TURN THIS INTO AN ARRAY OF NODES. CREATES TWO METHODS: SAVE NODE TO ARRAY OF NODES/AS WELL AS THE ORIGINAL X AND Y PROPERTIES IN OTHER ARRAY PROPERTIES ___ THE OTHER WOULD BE TO CHANGE THIS CODE INTO A FUNCTION THAT ITERATES THROUGH ALL OF THE NODES AND ADJUST THEM FOR THE CONTENT OFFSET
 
        spawnImage!.position.x = spawnImageNodeOriginalX! - scrollView.contentOffset.x
        spawnImage!.position.y = spawnImageNodeOriginalY! + scrollView.contentOffset.y
        
        basketImage!.position.x = basketImageNodeOriginalX! - scrollView.contentOffset.x
        basketImage!.position.y = basketImageNodeOriginalY! + scrollView.contentOffset.y
        
        backBoard!.position.x = backBoardNodeOriginalX! - scrollView.contentOffset.x
        backBoard!.position.y = backBoardNodeOriginalY! + scrollView.contentOffset.y
        
        basket!.position.x = basketNodeOriginalX! - scrollView.contentOffset.x
        basket!.position.y = basketNodeOriginalY! + scrollView.contentOffset.y
        
        bottomBasket!.position.x = bottomBasketNodeOriginalX! - scrollView.contentOffset.x
        bottomBasket!.position.y = bottomBasketNodeOriginalY! + scrollView.contentOffset.y
        
        hideScrollViewButton!.center.x = hideScrollViewButtonOriginalX! + scrollView.contentOffset.x
        hideScrollViewButton!.center.y = hideScrollViewButtonOriginalY! + scrollView.contentOffset.y
        
        var i = 0
        for Line in arrayOfLines {
            Line.position.x = linesOriginalXArray[i] - scrollView.contentOffset.x
            Line.position.y = linesOriginalYArray[i] + scrollView.contentOffset.y
            i = i + 1
        }

        i = 0
        for Star in arrayOfStars {
            Star.position.x = starsOriginalXArray[i] - scrollView.contentOffset.x
            Star.position.y = starsOriginalYArray[i] + scrollView.contentOffset.y
            i = i + 1
        }
        
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        self.checkBasketBoundary()
    }
    
    func checkBasketBoundary()
    {
        if ball != nil
        {
            if ball!.intersects(bottomBasket!)
            {
                let ballTransparencyAnimation = SKAction.fadeOut(withDuration: 3)
                
                ball?.run(ballTransparencyAnimation)
                 
                 // REMOVE SKSHAPENODE FROM .ADDCHILD
                
                print("CONGRATULATIONS")
                
                level += 1
                
                self.createLevel(levelNumber: level)
            }
        }
    }
    
    func createLevel(levelNumber level: Int)
    {
        switch(level)
        {
            case 0:
                if self.scrollView?.isHidden != true {
                    self.scrollView = setUpScrollView(withContentSize: 1000, andHeight: 1000)
                }
                self.createSpawnMarker(withX: -292, withY: 120)
                //SHOULD ONLY BE TWO POINTS. ALL THE OTHER POINTS SHOULD BE RELATIVE
                self.createBasket(withImage: "basket", withImageX: 100, withImageY: 0, withBackboardX: 125, withBackboardY: 0, withBasketX: 72, withBasketY: -32)
            
            case 1:
                break
            
            default:
                break
        }
        setOriginalPositionsForStaticNodes()
    }
    
    func setUpScrollView(withContentSize Width: CGFloat, andHeight: CGFloat) -> UIScrollView {
        let scrollView = UIScrollView(frame: self.view!.frame)
        scrollView.contentSize.width = Width
        scrollView.contentSize.height = andHeight
        scrollView.delegate = self
        self.view?.addSubview(scrollView)
        return scrollView
    }
    
    
    
    
    func createSpawnMarker(withX x: CGFloat, withY y: CGFloat)
    {
        let textureSpawn: SKTexture! = SKTexture(imageNamed: "spawn")
        let spawnSize: CGSize = textureSpawn.size()
        
        spawnImage = SKShapeNode(rectOf: spawnSize)
        spawnImage!.fillTexture = textureSpawn
        spawnImage!.fillColor = SKColor.white
        spawnImage!.position = CGPoint(x: x, y: y)
        self.addChild(spawnImage!)
    }
    
    func createBasket(withImage image: String, withImageX imageX: CGFloat, withImageY imageY: CGFloat, withBackboardX backBoardX: CGFloat, withBackboardY backBoardY: CGFloat, withBasketX basketX: CGFloat, withBasketY basketY: CGFloat)
    {
        //REFACTOR ALL THIS SO THAT IT CALLS A METHOD TO CREATE A BASKETIMAGE, METHOD TO CREATE THE BACKBOARD ETC>
        
        let textureBasket : SKTexture! = SKTexture(imageNamed: image)
        
        let basketSize: CGSize = textureBasket.size()
        
        basketImage = SKShapeNode(rectOf: basketSize)
        basketImage!.fillTexture = textureBasket
        basketImage!.fillColor = SKColor.white
        basketImage!.position = CGPoint(x: imageX, y: imageY)
        self.addChild(basketImage!)
        
        backBoard = SKShapeNode(rectOf: CGSize(width: 3, height: 60)) // CHANGE HERE FOR NEW IMAGE
        backBoard!.strokeColor = UIColor.clear // HERE TO ADJUST WHEN POSITIONING
        backBoard!.position = CGPoint(x: backBoardX, y: backBoardY)
        backBoard!.physicsBody = SKPhysicsBody(edgeChainFrom: backBoard!.path!)
        self.addChild(backBoard!)
        
        let basketBezierPath = UIBezierPath()
        // CHANGE ALL THIS FOR NEW IMAGE
        basketBezierPath.move(to: CGPoint(x: 0.0, y: 40.0))
        basketBezierPath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        basketBezierPath.addLine(to: CGPoint(x: 40.0, y: 0.0))
        basketBezierPath.addLine(to: CGPoint(x: 40.0, y: 40.0))
        
        basket = SKShapeNode(path: basketBezierPath.cgPath)
        basket!.strokeColor = UIColor.black // HERE TO ADJUST WHEN POSITIONING
        basket!.position = CGPoint(x: basketX, y: basketY)
        basket!.physicsBody = SKPhysicsBody(edgeChainFrom: basket!.path!)
        self.addChild(basket!)
        
        let bottomBasketBezierPath = UIBezierPath()
        // CHANGE ALL THIS FOR NEW IMAGE (BOX IN A BOX)
        bottomBasketBezierPath.move(to: CGPoint(x: 0.0, y: 35.0))
        bottomBasketBezierPath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        bottomBasketBezierPath.addLine(to: CGPoint(x: 35.0, y: 0.0))
        bottomBasketBezierPath.addLine(to: CGPoint(x: 35.0, y: 35.0))
        
        bottomBasket = SKShapeNode(path: bottomBasketBezierPath.cgPath)
        bottomBasket!.strokeColor = UIColor.red
        bottomBasket!.position = CGPoint(x: basketX + 2, y: basketY + 2)
        bottomBasket!.physicsBody = SKPhysicsBody(edgeChainFrom: bottomBasket!.path!)
        self.addChild(bottomBasket!)
    }
    
    func setOriginalPositionsForStaticNodes() {
        spawnImageNodeOriginalX = spawnImage!.position.x
        spawnImageNodeOriginalY = spawnImage!.position.y
        
        basketImageNodeOriginalX = basketImage!.position.x
        basketImageNodeOriginalY = basketImage!.position.y
        
        backBoardNodeOriginalX = backBoard!.position.x
        backBoardNodeOriginalY = backBoard!.position.y
        
        basketNodeOriginalX = basket!.position.x
        basketNodeOriginalY = basket!.position.y
        
        bottomBasketNodeOriginalX = basket!.position.x + 2
        bottomBasketNodeOriginalY = basket!.position.y + 2
    }
    
    
    func createBall(withImage: String)
    {
        if !self.ballFlag
        {
            self.setBallProperties(withImage: withImage)
            self.ballFlag = true
        }
    }
    
    func setBallProperties(withImage image: String)
    {
        let textureBall : SKTexture! = SKTexture(imageNamed: image)
        let ballSize: CGSize = textureBall.size()
        
        ball = SKShapeNode(circleOfRadius: ballSize.width / 2)
        ball!.fillTexture = textureBall
        ball!.fillColor = SKColor.white
        ball!.strokeColor = SKColor.clear
        ball!.position = (spawnImage?.position)!
        
        ball!.physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width / 2)
        ball!.physicsBody!.affectedByGravity = true
        ball!.physicsBody!.categoryBitMask = 0b0001
        ball!.physicsBody!.collisionBitMask = 0b10011
        
        self.addChild(ball!)
    }
    
    func cleanUpLevel () {
        self.removeAllChildren()
        arrayOfLines = Array()
        self.createLevel(levelNumber: level)
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        splineShapeNode = nil
        
        let touch = touches.first
        let point = touch?.location(in: self)

        mutablePath = CGMutablePath()
        mutablePath.move(to: point!)
        splineShapeNode = SKShapeNode(path: mutablePath)
        splineShapeNode.strokeColor = SKColor.black
        self.addChild(splineShapeNode)
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        let point = touch?.location(in: self)
        
        mutablePath.addLine(to: point!)
        splineShapeNode.path = mutablePath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        splineShapeNode.physicsBody = SKPhysicsBody(edgeChainFrom: splineShapeNode.path!)
        splineShapeNode.physicsBody?.affectedByGravity = false
        arrayOfLines.append(splineShapeNode)
        linesOriginalXArray.append(splineShapeNode.position.x)
        linesOriginalYArray.append(splineShapeNode.position.y)
    }
    
    func hideScrollView () {
        self.scrollView?.isHidden = true
    }
    
    func showScrollView () {
        self.scrollView?.isHidden = false
    }

}
