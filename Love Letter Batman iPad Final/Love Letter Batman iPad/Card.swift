//
//  Card.swift
//  LoveLetterBatmanEdition
//
//  Created by T5A User on 11/17/16.
//  Copyright © 2016 USAFA. All rights reserved.
//

import SpriteKit

class Card : SKSpriteNode {
    let cardType : Int
    let frontTexture :SKTexture
    
    func rotateCard(){
        let action = SKAction.rotateToAngle(3.14 / 2, duration: 0.5)
        runAction(action)
    }
    
    func moveToSelect(){
        let action = SKAction.moveTo(CGPoint(x: CGRectGetMidX(self.frame) - 100, y: 125), duration: 1)
        runAction(action)
    }
    
    func moveToRight(){
        let action = SKAction.moveByX(100, y: 0, duration: 1)
        runAction(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: Int) {
        self.cardType = cardType
        
        switch cardType {
        case 1:
            frontTexture = SKTexture(imageNamed: "BatmanCard.jpg")
        case 2:
            frontTexture = SKTexture(imageNamed: "CatwomanCard.jpg")
        case 3:
            frontTexture = SKTexture(imageNamed: "BaneCard.jpg")
        case 4:
            frontTexture = SKTexture(imageNamed: "RobinCard.jpg")
        case 5:
            frontTexture = SKTexture(imageNamed: "PoisonivyCard.jpg")
        case 6:
            frontTexture = SKTexture(imageNamed: "TwofaceCard.jpg")
        case 7:
            frontTexture = SKTexture(imageNamed: "HarleyCard.jpg")
        case 8:
            frontTexture = SKTexture(imageNamed: "JokerCard.jpg")
        case 9:
            frontTexture = SKTexture(imageNamed: "CardBack.jpg")
        default:
            frontTexture = SKTexture(imageNamed: "CardBack.jpg")
        }
        
        super.init(texture: frontTexture, color: .clearColor(), size: CGSize(width: 85.95349, height: 120))
    }
}
