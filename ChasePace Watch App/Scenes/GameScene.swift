//
//  GameScene.swift
//  ChasePace Watch App
//
//  Created by Rania Pryanka Arazi on 23/05/24.
//

import SpriteKit



class GameScene: SKScene {
    
    //MARK: - Properties
    var ground: SKSpriteNode!
    var monster: SKSpriteNode!
    
    //camera to follow the monster.
    var cameraNode = SKCameraNode()
    
    //move camera (200pt / second)
    var cameraMovePointPerSecond: CGFloat = 200
    
    //time tracking variables for frame updates
    var lastUpdateTime: TimeInterval = 0.0
    var dt: TimeInterval = 0.0
    
    //playable area
    var playableRect: CGRect {
        let ratio: CGFloat = 16/9
        let playableHeight = size.width / ratio
        let playableMargin = (size.height - playableHeight) /  2.0
        return CGRect(x: 0.0, y: playableMargin, width: size.width, height: playableHeight)
    }
    
    
    // display camera position
    var cameraRect: CGRect {
        let width = playableRect.width
        let height = playableRect.height
        let x = cameraNode.position.x - size.width/2.0 + (size.width - width) / 2.0
        let y = cameraNode.position.y - size.height/2.0 + (size.height - height) / 2.0
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    //MARK: - System
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setupNodes() //sets up the scene's nodes
    }
    
    //essential for time-based animations and movements in the game, such as moving the camera smoothly over time.
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        
        lastUpdateTime = currentTime
        
        //move  camera and the player based on the elapsed time
        moveCamera()
        movePlayer()
    }
    
    //MARK: - Configuration
    func setupNodes() {
        //add background
        createBG()
        
        //add ground
        createGround()
        
        //add player
        createMonster()
        
        //camera
        setupCamera()
    }
    
    //create background sprite nodes
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "BACKGROUND-2")
            bg.name = "BG"
            
            //default achorvalue/position for bg
            bg.anchorPoint = .zero //bottom-left corner.
            bg.position = CGPoint(x: CGFloat(i)*bg.frame.width, y: 0.0) //Each bg node: positioned next horizontally.
            bg.zPosition = -1.0 //layer behind other nodes
            addChild(bg)
        }
    }

    //create ground sprite nodes
    func createGround() {
        for i in 0...2 {
            ground = SKSpriteNode(imageNamed: "GROUND")
            ground.name = "Ground"
            
            //default achorvalue/position for ground
            ground.anchorPoint = .zero //bottom-left corner.
            ground.position = CGPoint(x: CGFloat(i)*ground.frame.width, y: 0.0) //Each ground node: positioned next horizontally.
            ground.zPosition = 1.0 //layer in front of background nodes
            addChild(ground)
        }
    }

    //create monster sprite nodes
    func createMonster() {
        monster = SKSpriteNode(imageNamed: "monster-1")
        monster.name = "Monster"
        
        //default achorvalue/position for monster
        monster.zPosition = 5.0
        monster.setScale(1.3) //monster size
        monster.position = CGPoint(x: frame.width/2.0, y: ground.frame.height + monster.frame.height/2.0) //set monster position on ground node
        
        //Running animation
        var texturesRun: [SKTexture] = []
        for i in 1...10 {
            texturesRun.append(SKTexture(imageNamed: "monster-\(i)"))
        }
        
        // repeat animation forever
        monster.run(.repeatForever(.animate(with: texturesRun, timePerFrame: 0.1)))
        addChild(monster)
    }

    
    //create camera sprite nodes
    func setupCamera() {
        addChild(cameraNode)
        camera = cameraNode
        
        //camera position --> middle of screen
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    
    //move camera horizontally --> infinite
    func moveCamera() {
        let amountToMove = CGPoint(x: cameraMovePointPerSecond * CGFloat(dt), y: 0.0)
        cameraNode.position += amountToMove
        
        //background --> infinity
        enumerateChildNodes(withName: "BG") { node, _ in
            let node = node as! SKSpriteNode
            if node.position.x + node.frame.width < self.cameraRect.origin.x {
                node.position = CGPoint(x: node.position.x + node.frame.width * 2.0, y: node.position.y)
            }
        }

        //ground --> infinity
        enumerateChildNodes(withName: "Ground") { node, _ in
            let node = node as! SKSpriteNode
            if node.position.x + node.frame.width < self.cameraRect.origin.x {
                node.position = CGPoint(x: node.position.x + node.frame.width * 2.0, y: node.position.y)
            }
        }
    }
    
    //Updates the player’s position based on the elapsed time.
    func movePlayer() {
        let amountToMove = cameraMovePointPerSecond * CGFloat(dt)
        monster.position.x += amountToMove
    }
}
