//
//  HelloScene.swift
//  SpriteWalkthrough
//
//  Created by Christian Sandvoß on 13/07/14.
//  Copyright (c) 2014 Christian Sandvoß. All rights reserved.
//

import SpriteKit

class HelloScene: SKScene{
    var contendCreated :Bool = false
    
    override func didMoveToView(view: SKView!) {
        if (!self.contendCreated){
            self.createSeceneContents()
            self.contendCreated = true
        }
    }
    
    func createSeceneContents(){
        self.backgroundColor = SKColor.blueColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.addChild(self.newHelloNode())
    }
    
    func newHelloNode() -> SKLabelNode {
        var helloNode :SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
        helloNode.name = "helloNode"
        helloNode.text = "Hello World"
        helloNode.fontSize = 42
        helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        return helloNode
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        var helloNode = self.childNodeWithName("helloNode")
        
        if(helloNode != nil){
            helloNode.name = nil
            let moveUp = SKAction.moveByX(0, y: 100.0, duration: 0.5)
            let zoom = SKAction.scaleTo(2.0, duration: 0.25)
            let pause = SKAction.waitForDuration(0.5)
            let fadeAway = SKAction.fadeOutWithDuration(0.25)
            let remove = SKAction.removeFromParent()
            let moveSequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])

            helloNode.runAction(moveSequence, completion: {
                let spaceshipScene = SpaceshipScene(size: self.size)
                let doors = SKTransition.doorsOpenVerticalWithDuration(0.5)
                self.view.presentScene(spaceshipScene, transition: doors)
            })
        }
    }
}
