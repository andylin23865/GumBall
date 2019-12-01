//
//  GameControl.swift
//  GumBalls
//
//  Created by apple on 2019/12/1.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

func physicAttack(floorNum:Int){
    if allFloor[floorNum].floorStatus == FloorStatus.isMonster{
        allFloor[floorNum].monster.life = allFloor[floorNum].monster.life - GumBallData.physicAttack
        GumBallData.life = GumBallData.life - allFloor[floorNum].monster.attack
        //updateTheAllMonster()
    }
}
