//
//  GameScene.swift
//  GumBalls
//
//  Created by apple on 2019/11/26.
//  Copyright © 2019 andy. All rights reserved.
//

import SpriteKit
import GameplayKit

enum GameStatus{
    case idle
    
    case running
    
    case over
}

class GameScene: SKScene {
    
    func addNewBack(){

        attackGum = SKSpriteNode(imageNamed: "physicAttack")
        attackGum.size = CGSize(width: GumBallImage.size.width*0.5, height: GumBallImage.size.width*0.5)
        addChild(attackGum)
        attackGum.position = CGPoint(x: GumBallImage.position.x-GumBallImage.size.width*0.8, y: GumBallImage.position.y-GumBallImage.size.height*(0.4))
        
        lifeGum = SKSpriteNode(imageNamed: "lifeNum")
        lifeGum.size = CGSize(width: GumBallImage.size.width*0.5, height: GumBallImage.size.width*0.5)
        addChild(lifeGum)
        lifeGum.position = CGPoint(x: GumBallImage.position.x-GumBallImage.size.width*0.8, y: GumBallImage.position.y+GumBallImage.size.height*0.4)
        
        magicAttackGum = SKSpriteNode(imageNamed: "magicAttack")
        magicAttackGum.size = CGSize(width: GumBallImage.size.width*0.5, height: GumBallImage.size.width*0.5)
        addChild(magicAttackGum)
        magicAttackGum.position = CGPoint(x: GumBallImage.position.x+GumBallImage.size.width*0.8, y: GumBallImage.position.y-GumBallImage.size.height*(0.4))
        
        magicGum = SKSpriteNode(imageNamed: "magicNum")
        magicGum.size = CGSize(width: GumBallImage.size.width*0.5, height: GumBallImage.size.width*0.5)
        addChild(magicGum)
        magicGum.position = CGPoint(x: GumBallImage.position.x+GumBallImage.size.width*0.8, y: GumBallImage.position.y+GumBallImage.size.height*0.4)
    }
    
    func addNewnum(){
        attackNumGum = SKLabelNode(text: (String)(GumBallData.physicAttack))
        //attackNumGum = SKLabelNode(text: "1000000")
        attackNumGum.fontName = "Apple SD Gothic Neo"
        attackNumGum.fontColor = SKColor.black
        attackNumGum.fontSize = 10.0
        //attackNumGum.position = CGPoint(x: 0, y: 0-attackGum.size.height*0.2)
        addChild(attackNumGum)
        attackNumGum.position = CGPoint(x: GumBallImage.position.x-GumBallImage.size.width*0.8, y: GumBallImage.position.y-GumBallImage.size.height*(0.4+0.05))
        attackNumGum.zPosition = 2.0
        
        lifeNumGum = SKLabelNode(text: (String)(GumBallData.life))
        //lifeNumGum = SKLabelNode(text: "10000000")
        lifeNumGum.fontName = "Apple SD Gothic Neo"
        lifeNumGum.fontColor = SKColor.black
        lifeNumGum.fontSize = 10.0
        addChild(lifeNumGum)
        lifeNumGum.position = CGPoint(x: GumBallImage.position.x-GumBallImage.size.width*0.8, y: GumBallImage.position.y+GumBallImage.size.height*(0.4-0.05))
        //lifeNumGum.position = CGPoint(x: 0, y: 0-lifeGum.size.height*0.2)
        lifeNumGum.zPosition = 2.0
        
        magicAttackNumGum = SKLabelNode(text: (String)(GumBallData.magicAttack))
        magicAttackNumGum.fontName = "Apple SD Gothic Neo"
        magicAttackNumGum.fontColor = SKColor.black
        magicAttackNumGum.fontSize = 10.0
        addChild(magicAttackNumGum)
        magicAttackNumGum.position = CGPoint(x: GumBallImage.position.x+GumBallImage.size.width*0.8, y: GumBallImage.position.y-GumBallImage.size.height*(0.4+0.05))
        //magicAttackNumGum.position = CGPoint(x: 0, y: 0-magicAttackGum.size.height*0.2)
        magicAttackNumGum.zPosition = 2.0
        
        magicNumGum = SKLabelNode(text: (String)(GumBallData.magic))
        magicNumGum.fontName = "Apple SD Gothic Neo"
        magicNumGum.fontColor = SKColor.black
        magicNumGum.fontSize = 10.0
        addChild(magicNumGum)
        magicNumGum.position = CGPoint(x: GumBallImage.position.x+GumBallImage.size.width*0.8, y: GumBallImage.position.y+GumBallImage.size.height*(0.4-0.05))
        //magicNumGum.position = CGPoint(x: 0, y: 0-magicGum.size.height*0.2)
        magicNumGum.zPosition = 2.0
        
    }
    
    func shuffle(){
        //游戏的初始化过程
        winner.text = "START NOW"
        winner.fontSize = 65
        winner.fontColor = SKColor.green
        winner.position = CGPoint(x: frame.midX, y: frame.midY)
           
        addChild(winner)
        gameStatus = .idle
    }
    
    func createTheBasicBack(){
        GumBallImage = SKSpriteNode(imageNamed: "player1")
         packageImage = SKSpriteNode(imageNamed: "package")
         packageImage.size = CGSize(width: self.size.width*0.18, height: self.size.width*0.18)
         reelImage = SKSpriteNode(imageNamed: "reel")
         reelImage.size = CGSize(width: self.size.width*0.18, height: self.size.width*0.18)
         
         addChild(GumBallImage)
         addChild(packageImage)
         addChild(reelImage)
        
        GumBallImage.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.1)
        packageImage.position = CGPoint(x: self.size.width*0.2, y: self.size.height*0.1)
        reelImage.position = CGPoint(x: self.size.width*0.8, y: self.size.height*0.1)
    }
    
    func startGame(){
        //游戏的开始过程
        self.removeChildren(in: [winner])
        
        level = 1
        monsterNum = level/5+5
        
        winner.text = "迷宫第\(level!)层          探索点：\(GumBallData.explore)"
        winner.fontSize = 20
        winner.fontColor = SKColor.green
        winner.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.9)
           
        addChild(winner)
        
        createTheBasicBack()
        
        createThePropSet()
        calculateTheMonsterIndex(allFloorNum: 30, allTheMonsterNum: monsterNum)
        calculateTheProp(allFloorNum: 30, allPropNum: 2, kind: .isLifeBottle)
        calculateTheProp(allFloorNum: 30, allPropNum: 1, kind: .isAttackBottle)
        calculateTheProp(allFloorNum: 30, allPropNum: 3, kind: .isExplore)
        
        addNewBack()
        
        addNewnum()

        GumStartDoSomething()
        creatTheFloor()
        gameStatus = .running
    }
    
    func gameOver(){
        //游戏失败
        
        gameStatus = .over
    }
    
    override func willMove(from view: SKView) {
        lastScene = self
    }
    
    override func didMove(to view: SKView) {
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        //var back = UIColor(patternImage: UIImage(named: "background"))
        //self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        if !comeBack {
            shuffle()
        }else{
            comeBack = false
            self.view?.presentScene(lastScene)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case .idle:
            startGame()
        case .running:
            //GumBallData.life = GumBallData.life-1
            for touch in touches{
                let tmp = touch.location(in: self)
                let floorNum = whichFloor(touch: tmp)
                if(floorNum != -1) {openTheFloorFlash(floorNum: floorNum)}
                if packageImage.contains(touch.location(in: self)){
                    let doors = SKTransition.doorway(withDuration: 0.5)
                    let nextPackagesScene = PackageScene()
                    nextPackagesScene.size = CGSize(width: self.size.width*0.5, height: self.size.height*0.5)
                    nextPackagesScene.scaleMode = .aspectFill
                    self.view?.presentScene(nextPackagesScene,transition: doors)
                }
            }
        case .over:
            print("return\n")
        default:
            print("error")
        }
    }
    
    func GumStartDoSomething(){
        //let DoAction = SKAction.animate(with: [SKTexture(imageNamed: "player1"),SKTexture(imageNamed: "player2")], timePerFrame: 0.3)
        
        //GumBall.run(SKAction.repeat(DoAction, count: 10))
        
        //GumBall to start move
    }
    
    func MoveUpDown(node:SKNode){
        let DoAction1 = SKAction.moveBy(x: 0, y: 2, duration: 0.7)
        let DoAction2 = SKAction.moveBy(x: 0, y: -2, duration: 0.5)
        let action = SKAction.sequence([DoAction1,DoAction2])
        node.run(SKAction.repeatForever(action))
    }
    
    func MoveOut(node:SKNode)
    {
        let DoAction1 = SKAction.moveBy(x: node.position.x, y: node.position.y, duration: 1)
        node.run(DoAction1, completion: {() in
            self.removeChildren(in: [node])
        })
    }
    
    func moveTo(node:SKNode,dest:CGPoint,duration:TimeInterval){
        let action = SKAction.move(to: dest, duration: duration)
        node.run(action, completion: { () in
            self.removeChildren(in: [node])
        })
    }
    
    func creatTheFloor(){
        for i in 0..<6{
            for j in 0..<5{
                let floorTmp = floor(coord: CGPoint(x: (Double)(self.size.width)*(0.2*(Double)(j+1)-0.1), y: (Double)(self.size.height)*((Double)(i+1)*0.10+0.18)),open:false)
                floorTmp.eachFloor = SKSpriteNode(imageNamed: "floorCover")
                floorTmp.eachFloor.position = floorTmp.coord
                floorTmp.eachFloor.size = CGSize(width: 60, height: 60)
                floorTmp.floorStatus = allProp[i*5 + j]
                allFloor.append(floorTmp)
                addChild(floorTmp.eachFloor)
            }
        }
    }
    
    func openTheFloorFlash(floorNum:Int){
        if(allFloor[floorNum].open == false){
            allFloor[floorNum].open = true
            var DoAction:SKAction!
            var notMonster = true
            for theMonster in allMonster{
                if theMonster.index == floorNum{
                    notMonster = false
                    DoAction = SKAction.animate(with: [SKTexture(imageNamed: "floorCover"),SKTexture(imageNamed: "monster1")], timePerFrame: 0.2)
                    allFloor[floorNum].eachFloor.run(DoAction)
                    creatTheMonsterLifeAndAttackFlash(floorNum: floorNum,life: theMonster.life,attack: theMonster.attack)
                    allFloor[floorNum].monster = theMonster
                }
            }
            if notMonster {
                switch allFloor[floorNum].floorStatus {
                case .isLifeBottle:
                    DoAction = SKAction.animate(with: [SKTexture(imageNamed: "floorCover"),SKTexture(imageNamed: "lifeBottle")], timePerFrame: 0.2)
                    allFloor[floorNum].eachFloor.run(DoAction)
                case .isNothing:
                    DoAction = SKAction.animate(with: [SKTexture(imageNamed: "floorCover"),SKTexture(imageNamed: "nothing")], timePerFrame: 0.2)
                    allFloor[floorNum].eachFloor.run(DoAction)
                case .isAttackBottle:
                    DoAction = SKAction.animate(with: [SKTexture(imageNamed: "floorCover"),SKTexture(imageNamed: "attackBottle")], timePerFrame: 0.2)
                    allFloor[floorNum].eachFloor.run(DoAction)
                case .isExplore:
                        DoAction = SKAction.animate(with: [SKTexture(imageNamed: "floorCover"),SKTexture(imageNamed: "explore")], timePerFrame: 0.2)
                        allFloor[floorNum].eachFloor.run(DoAction)
                default:
                    print("noThing")
                }
            }
        }
        else{
            switch allFloor[floorNum].floorStatus {
            case .isMonster:
                physicAttack(floorNum: floorNum)
                updateTheMonster(floorNum: floorNum)
                updateTheGumBall()
            case .isLifeBottle:
                GumBallData.life = GumBallData.life + 5
                updateTheGumBall()
                removeTheBottle(floorNum: floorNum)
            case .isAttackBottle:
                GumBallData.physicAttack = GumBallData.physicAttack + 1
                updateTheGumBall()
                removeTheBottle(floorNum: floorNum)
            case .isExplore:
                GumBallData.explore = GumBallData.explore + 10
                updateTheGumBall()
                removeTheBottle(floorNum: floorNum)
            default:
                print("nothing")
            }
        }
    }
    
    func creatTheMonsterLifeAndAttackBack(floorNum:Int){
        allFloor[floorNum].attack = SKSpriteNode(imageNamed: "physicAttack")
        allFloor[floorNum].attack.size = CGSize(width: allFloor[floorNum].eachFloor.size.width*0.25, height: allFloor[floorNum].eachFloor.size.height*0.25)
        addChild(allFloor[floorNum].attack)
        allFloor[floorNum].attack.position = CGPoint(x: allFloor[floorNum].eachFloor.position.x-allFloor[floorNum].eachFloor.size.width*0.4, y: allFloor[floorNum].eachFloor.position.y-allFloor[floorNum].eachFloor.size.height*(0.4))
        
        allFloor[floorNum].life = SKSpriteNode(imageNamed: "lifeNum")
        allFloor[floorNum].life.size = CGSize(width: allFloor[floorNum].eachFloor.size.width*0.25, height: allFloor[floorNum].eachFloor.size.height*0.25)
        addChild(allFloor[floorNum].life)
        allFloor[floorNum].life.position = CGPoint(x: allFloor[floorNum].eachFloor.position.x-allFloor[floorNum].eachFloor.size.width*0.4, y: allFloor[floorNum].eachFloor.position.y+allFloor[floorNum].eachFloor.size.height*0.4)
    }
    
    func creatTheMonsterLifeAndAttackNum(floorNum:Int,life:Int,attack:Int){
        allFloor[floorNum].attackNum = SKLabelNode(text: (String)(attack))
        allFloor[floorNum].attackNum.fontColor = SKColor.black
        allFloor[floorNum].attackNum.fontName = "Apple SD Gothic Neo"
        allFloor[floorNum].attackNum.fontSize = 10.0
        addChild(allFloor[floorNum].attackNum)
        allFloor[floorNum].attackNum.position = CGPoint(x: allFloor[floorNum].eachFloor.position.x-allFloor[floorNum].eachFloor.size.width*0.4, y: allFloor[floorNum].eachFloor.position.y-allFloor[floorNum].eachFloor.size.height*(0.4+0.05))
        //allFloor[floorNum].attackNum.position = CGPoint(x: 0, y: 0-allFloor[floorNum].attack.size.height*0.2)
        allFloor[floorNum].attackNum.zPosition = 2.0
        
        allFloor[floorNum].lifeNum = SKLabelNode(text: (String)(life))
        allFloor[floorNum].lifeNum.fontColor = SKColor.black
        allFloor[floorNum].lifeNum.fontName = "Apple SD Gothic Neo"
        allFloor[floorNum].lifeNum.fontSize = 10.0
        addChild(allFloor[floorNum].lifeNum)
        allFloor[floorNum].lifeNum.position = CGPoint(x: allFloor[floorNum].eachFloor.position.x-allFloor[floorNum].eachFloor.size.width*0.4, y: allFloor[floorNum].eachFloor.position.y+allFloor[floorNum].eachFloor.size.height*(0.4-0.05))
        //allFloor[floorNum].lifeNum.position = CGPoint(x: 0, y: 0-allFloor[floorNum].life.size.height*0.2)
        allFloor[floorNum].lifeNum.zPosition = 2.0
    }
    
    func creatTheMonsterLifeAndAttackFlash(floorNum:Int,life:Int,attack:Int){
        
        creatTheMonsterLifeAndAttackBack(floorNum: floorNum)
        
        creatTheMonsterLifeAndAttackNum(floorNum: floorNum, life: life, attack: attack)
    }
    
    
    
    func removeTheMonster(floorNum:Int){
        self.removeChildren(in: [allFloor[floorNum].attack,allFloor[floorNum].attackNum,allFloor[floorNum].life,allFloor[floorNum].lifeNum])
        MoveOut(node: allFloor[floorNum].eachFloor)
        allFloor[floorNum] = floor(coord: allFloor[floorNum].coord, open: allFloor[floorNum].open)
        allFloor[floorNum].eachFloor = SKSpriteNode(imageNamed: "nothing")
        allFloor[floorNum].eachFloor.position = allFloor[floorNum].coord
        allFloor[floorNum].eachFloor.size = CGSize(width: 60, height: 60)
        allFloor.append(allFloor[floorNum])
        addChild(allFloor[floorNum].eachFloor)
    }
    
    func removeTheBottle(floorNum:Int){
        moveTo(node: allFloor[floorNum].eachFloor, dest: GumBallImage.position, duration: 1)
        allFloor[floorNum] = floor(coord: allFloor[floorNum].coord, open: allFloor[floorNum].open)
        allFloor[floorNum].eachFloor = SKSpriteNode(imageNamed: "nothing")
        allFloor[floorNum].eachFloor.position = allFloor[floorNum].coord
        allFloor[floorNum].eachFloor.size = CGSize(width: 60, height: 60)
        allFloor.append(allFloor[floorNum])
        addChild(allFloor[floorNum].eachFloor)
    }
    
    func updateTheMonster(floorNum:Int){
        if allFloor[floorNum].monster.life > 0{
            allFloor[floorNum].attackNum.text = (String)(allFloor[floorNum].monster.attack)
            allFloor[floorNum].lifeNum.text =  (String)(allFloor[floorNum].monster.life)
        }else{
            removeTheMonster(floorNum: floorNum)
        }
    }
    
    func updateTheGumBall(){
        attackNumGum.text = (String)(GumBallData.physicAttack)
        lifeNumGum.text = (String)(GumBallData.life)
        magicAttackNumGum.text = (String)(GumBallData.magicAttack)
        magicNumGum.text = (String)(GumBallData.magic)
        updateTheExploreAndLevel()
    }
    
    func updateTheExploreAndLevel(){
        winner.text = "迷宫第\(level!)层          探索点：\(GumBallData.explore)"
    }
    
    func updateTheLevelAndMonsterNum(){
        level = level+1
        monsterNum = level/5+5
        updateTheExploreAndLevel()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //updateTheGumBall()
    }
}
