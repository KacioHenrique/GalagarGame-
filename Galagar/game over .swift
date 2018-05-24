//
//  game over .swift
//  Galagar
//
//  Created by kacio henrique couto batista on 23/05/2018.
//  Copyright © 2018 kacio henrique couto batista. All rights reserved.
//

import Foundation
import SpriteKit
class GameEnd : SKScene {
    let reset = UIButton()
    override func didMove(to view: SKView) {
            scene?.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        reset.frame = CGRect(x: 100, y: 0, width: 40, height: 30)
        reset.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        reset.addTarget(self, action: #selector(resat), for:.touchDown)
        //self.view?.presentScene()
        self.view?.addSubview(reset)
    }
    @objc func resat(){
        let aux = GameScene()
        aux.size.width = 750.0
        aux.size.height = 1334.0
        self.view?.presentScene(aux)
        reset.removeFromSuperview()
    }
}
