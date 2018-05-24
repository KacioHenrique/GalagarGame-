//
//  ExtensionGameScene.swift
//  Galagar
//
//  Created by kacio henrique couto batista on 22/05/2018.
//  Copyright © 2018 kacio henrique couto batista. All rights reserved.
//

import Foundation
import SpriteKit
extension GameScene : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask != contact.bodyB.categoryBitMask {
            if contact.bodyA.categoryBitMask == 1 {
                colisionPlayerAndMeteor(player: contact.bodyA, meteor: contact.bodyB)
            }
            else if contact.bodyA.categoryBitMask == 2 {
                colisionBulletAndMeteor(bullet: contact.bodyA, meteor: contact.bodyB)
            }
        }
    }
    
    func deletaMeteor(merteoro:SKSpriteNode){
        merteoro.removeFromParent()
    }
    func colisionPlayerAndMeteor (player:SKPhysicsBody , meteor:SKPhysicsBody){
        if let meteor = meteor.node as? SKSpriteNode {
            deletaMeteor(merteoro: meteor)
        }
        score.removeFromSuperview()
        self.view?.presentScene(GameEnd())
    }
    func colisionBulletAndMeteor(bullet:SKPhysicsBody,meteor:SKPhysicsBody){
        if let bullet = bullet.node as? SKSpriteNode , let meteor = meteor.node as? SKSpriteNode {
            self.pontGame += 1
            bullet.removeFromParent()
            meteor.removeFromParent()
        }
    }
}
