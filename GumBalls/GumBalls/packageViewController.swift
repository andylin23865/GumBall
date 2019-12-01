//
//  packageViewController.swift
//  GumBalls
//
//  Created by apple on 2019/12/1.
//  Copyright © 2019 andy. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class packageViewController: UIViewController {

    @IBOutlet var myView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SKScene()
        scene.scaleMode = .aspectFill

        //view.backgroundColor = UIColor(patternImage: back.image!)
        myView.presentScene(scene)
        
        
        myView.ignoresSiblingOrder = true
        
        myView.showsFPS = true
        myView.showsNodeCount = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
