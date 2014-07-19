//
//  SpaceshipScene.swift
//  SpriteWalkthrough
//
//  Created by Christian Sandvoß on 13/07/14.
//  Copyright (c) 2014 Christian Sandvoß. All rights reserved.
//

import SpriteKit
import Foundation

class SpaceshipScene :SKScene{
    var contentCreated = false
    
    override func didMoveToView(view: SKView!) {
        if(!self.contentCreated){
            self.createSceneContents()
            self.contentCreated = true
        }
    }
    
    func createSceneContents() {
        self.backgroundColor = SKColor.blackColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
        
        var spaceship = self.newSpaceship()
        spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150)
        self.addChild(spaceship)
        
        let makeRocks = SKAction.sequence([
            SKAction.runBlock(self.addRock),
            SKAction.waitForDuration(0.10, withRange: 0.15)
            ])
        self.runAction(SKAction.repeatActionForever(makeRocks))
    }
    
    func newSpaceship() -> SKSpriteNode {
        let hull = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(64, 32))
        hull.physicsBody = SKPhysicsBody(rectangleOfSize: hull.size)
        hull.physicsBody.dynamic = false
        
        let light1 = self.newLight()
        light1.position = CGPointMake(-28.0, 6.0)
        hull.addChild(light1)
        
        let light2 = self.newLight()
        light2.position = CGPointMake(28.0, 6.0)
        hull.addChild(light2)
        
        
        let hover = SKAction.sequence([
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(100, y: 50.0, duration: 1.0),
            SKAction.waitForDuration(1.0),
            SKAction.moveByX(-100.0, y: -50, duration: 1.0)
            ])
        hull.runAction(SKAction.repeatActionForever(hover))
        return hull
    }
    
    func newLight() -> SKSpriteNode {
        let light = SKSpriteNode(color: SKColor.yellowColor(), size: CGSizeMake(8, 8))
        
        let blink = SKAction.sequence([
            SKAction.fadeOutWithDuration(0.25),
            SKAction.fadeInWithDuration(0.25)
            ])
        let blinkForever = SKAction.repeatActionForever(blink)
        
        light.runAction(blinkForever)
        return light
    }
    
    func skRandf() -> CGFloat{
        return Float(rand()) / Float(RAND_MAX)
    }
    
    func skRand(low: CGFloat, high: CGFloat) -> CGFloat {
        return self.skRandf() * (high - low) + low;
    }
    
    func addRock(){
        let rock = SKSpriteNode(color: SKColor.brownColor(), size: CGSizeMake(8, 8))
        rock.position = CGPointMake(self.skRand(0, high: self.size.width), self.size.height - 50)
        rock.name = "rock"
        rock.physicsBody = SKPhysicsBody(rectangleOfSize: rock.size)
        rock.physicsBody.usesPreciseCollisionDetection = true
        self.addChild(rock)
    }
    
    override func didSimulatePhysics() {
        self.enumerateChildNodesWithName("rock"){
            node, stop in
            if(node.position.y < 0){
                node.runAction(SKAction.removeFromParent())
            }
        }
    }
}
