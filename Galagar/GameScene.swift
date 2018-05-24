//
//  GameScene.swift
//  Galagar
//
//  Created by kacio henrique couto batista on 22/05/2018.
//  Copyright © 2018 kacio henrique couto batista. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var player = SKSpriteNode(imageNamed: "nave menor")
    var score = UILabel()
    var pontGame:Int = 0
    override func didMove(to view: SKView) {
        print("x = \(self.frame.width)")
        print("y = \(self.frame.height)")
        self.addChild(SKEmitterNode(fileNamed:"star ")!)
        physicsWorld.contactDelegate = self
        player.position = CGPoint(x: self.size.width/4, y: -self.size.height/4)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = PhysiscsCategory.player
        player.physicsBody?.contactTestBitMask = PhysiscsCategory.alien
        player.physicsBody?.isDynamic = false
        score.frame = CGRect(x: 0, y: 0, width: self.size.width *  0.2, height: self.size.height * 0.03)
        //score.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        score.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        score.text = "Score : \(pontGame)"
        self.view?.addSubview(score)
        self.addChild(player)
    }
    func spawnbullet(){
        let bullet = SKSpriteNode(imageNamed:"pill")
        bullet.position = CGPoint(x: self.player.position.x, y:self.player.position.y )
        bullet.zPosition = -5
        let acionMove = SKAction.moveTo(y: self.size.height, duration: 1)
        let acionMoveDone = SKAction.removeFromParent()
        bullet.run(SKAction.sequence([acionMove,acionMoveDone]))
        bullet.physicsBody = SKPhysicsBody(rectangleOf: bullet.size)
        bullet.physicsBody?.affectedByGravity = false
        bullet.physicsBody?.isDynamic = false
        bullet.physicsBody?.categoryBitMask = PhysiscsCategory.bullet
        bullet.physicsBody?.contactTestBitMask = PhysiscsCategory.alien
        self.addChild(bullet)
    }
    func spawnMeteor(){
        let meteor = SKSpriteNode(imageNamed:"meteor")
        let max = self.size.width
        _ = -meteor.size.width
        let x : Int
        //max = (max - min) + min
        let random = arc4random() % UInt32(max)
        if random % 2 == 0 {
            x = Int(random) * (-1)
        }else{
            x = Int(random)
        }
        let actionMove = SKAction.moveTo(y: -self.size.height, duration: 10)
        let actionMoveDone = SKAction.removeFromParent()
        meteor.physicsBody = SKPhysicsBody(circleOfRadius: meteor.size.width/10)
        meteor.position = CGPoint(x:CGFloat(x), y:CGFloat(self.size.height-meteor.size.height))
        meteor.run(SKAction.sequence([actionMove,actionMoveDone]))
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.categoryBitMask = PhysiscsCategory.alien
        meteor.physicsBody?.contactTestBitMask = PhysiscsCategory.bullet
        meteor.physicsBody?.contactTestBitMask = PhysiscsCategory.player
        self.addChild(meteor)
        
    }
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        player.position = pos
        print("a posição em x : \(player.position.x) e a posição em y : \(player.position.y)")
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        spawnbullet()
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        let sec = Int(currentTime)
        if sec % 5 == 1 {
            spawnMeteor()
        }
        score.text = "Score :\(pontGame)"

    }
}
