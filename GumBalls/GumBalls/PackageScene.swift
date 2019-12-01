//
//  PackageScene.swift
//  GumBalls
//
//  Created by apple on 2019/12/1.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PackageScene: SKScene {
    
    var last_view:SKView!
    
    override func didMove(to view: SKView) {
        last_view = view
        creatTheFloor()
        comeBack = true
    }
    
    func creatTheFloor(){
        for i in 0..<6{
            for j in 0..<5{
                let floorTmp = floor(coord: CGPoint(x: (Double)(self.size.width)*(0.2*(Double)(j+1)-0.1), y: (Double)(self.size.height)*((Double)(i+1)*0.10+0.18)),open:false)
                floorTmp.eachFloor = SKSpriteNode(imageNamed: "floorCover")
                floorTmp.eachFloor.position = floorTmp.coord
                floorTmp.eachFloor.size = CGSize(width: 60, height: 60)
                
                addChild(floorTmp.eachFloor)
            }
        }
    }
    
    func backToLast(){
        let doors = SKTransition.doorway(withDuration: 0.5)
        let nextPackagesScene = GameScene()
        nextPackagesScene.size = self.size
        nextPackagesScene.scaleMode = .aspectFill
        self.view?.presentScene(nextPackagesScene,transition: doors)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        backToLast()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
