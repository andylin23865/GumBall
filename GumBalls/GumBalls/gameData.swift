//
//  gameControl.swift
//  GumBalls
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

enum FloorStatus{
    case isMonster
    
    case isLifeBottle
    
    case isAttackBottle
    
    case isExplore
    
    case isNothing
}

class GumBall {
    var life:Int
    var magic:Int
    var physicAttack:Int
    var magicAttack:Int
    var explore:Int
    init(life:Int,magic:Int,physicAttack:Int,magicAttack:Int) {
        self.life = life
        self.magic = magic
        self.magicAttack = magicAttack
        self.physicAttack = physicAttack
        explore = 0
    }
}

class Monster {
    var life:Int
    var attack:Int
    var index:Int!
    init(life:Int,attack:Int) {
        self.life = life
        self.attack = attack
    }
}

class floor{
    var coord:CGPoint
    var eachFloor:SKSpriteNode!
    var open:Bool
    var floorStatus:FloorStatus!
    var monster:Monster!
    var life:SKSpriteNode!
    var lifeNum:SKLabelNode!
    var attack:SKSpriteNode!
    var attackNum:SKLabelNode!
    init(coord:CGPoint,open:Bool){
        self.coord = coord
        self.open = open
    }
}

//data
var allFloor = [floor]()
var GumBallData = GumBall(life: 50, magic: 30, physicAttack: 3, magicAttack: 2)
var allMonster = [Monster]()
var allProp = [FloorStatus]()
//node data
var GumBallImage:SKSpriteNode!
var packageImage:SKSpriteNode!
var reelImage:SKSpriteNode!
var gameStatus:GameStatus = .idle
var attackGum:SKSpriteNode!
var attackNumGum:SKLabelNode!
var lifeGum:SKSpriteNode!
var lifeNumGum:SKLabelNode!
var magicAttackGum:SKSpriteNode!
var magicAttackNumGum:SKLabelNode!
var magicGum:SKSpriteNode!
var magicNumGum:SKLabelNode!
//某些参数
var monsterNum:Int!
var level:Int!


let winner = SKLabelNode(fontNamed: "Chalkduster")

var lastScene:SKScene!
var comeBack = false


func createThePropSet(){
    for _ in 0..<30{
        allProp.append(.isNothing)
    }
}

func inTheFloor(index:CGPoint,center:CGPoint,size_x:Double,size_y:Double)->Bool{
    return ((Double)(index.x) > (Double)(center.x)-size_x/2 && (Double)(index.x) < (Double)(center.x)+size_x/2) && ((Double)(index.y) > (Double)(center.y)-size_y/2 && (Double)(index.y) < (Double)(center.y)+size_y/2)
}

func whichFloor(touch:CGPoint)->Int{
    for i in 0..<30{
        if(inTheFloor(index: touch, center: allFloor[i].eachFloor.position, size_x: Double(allFloor[i].eachFloor.size.width),size_y: Double(allFloor[i].eachFloor.size.height))){
            return i
        }
    }
    return -1
}


func updateTheAllMonster(){
    for i in 0..<allMonster.count{
        allMonster[i] = allFloor[allMonster[i].index].monster
    }
}


func creatAMosterData(index:Int){
    let monTmp = Monster(life: 5+level*2, attack: 1+level/2)
    monTmp.index = index
    allMonster.append(monTmp)
}

func calculateTheMonsterIndex(allFloorNum:Int,allTheMonsterNum:Int){
    var num = 0
    while(num < allTheMonsterNum){
        let randomNum = Int(arc4random()%(UInt32)(allFloorNum))
        var notSame = true
        for theMonster in allMonster{
            if randomNum == theMonster.index{notSame = false}
        }
        if notSame {
            creatAMosterData(index: randomNum)
            allProp[randomNum] = .isMonster
            num = num+1
        }
    }
}

func calculateTheProp(allFloorNum:Int,allPropNum:Int,kind:FloorStatus){
    var num = 0
    while(num < allPropNum){
        let randomNum = Int(arc4random()%(UInt32)(allFloorNum))
        if allProp[randomNum] == .isNothing {
            allProp[randomNum] = kind
            num = num+1
        }
    }
}
