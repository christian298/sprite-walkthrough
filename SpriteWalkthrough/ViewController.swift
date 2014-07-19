//
//  ViewController.swift
//  SpriteWalkthrough
//
//  Created by Christian Sandvoß on 13/07/14.
//  Copyright (c) 2014 Christian Sandvoß. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        let spriteView :SKView = self.view as SKView
        spriteView.showsDrawCount = true
        spriteView.showsNodeCount = true
        spriteView.showsFPS = true        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let hello :HelloScene = HelloScene(size: CGSizeMake(768, 1024))
        let spriteView :SKView = self.view as SKView
        spriteView.presentScene(hello)
    }


}

