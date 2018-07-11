//
//  GameScene.swift
//  Love Letter Batman iPad
//
//  Created by T6A User on 11/29/16.
//  Copyright (c) 2016 USAFA. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var numPlayers : Int = 4
    var nameList : [String] = []
    var myBoard : BoardModel = BoardModel(size: 4)
    var choosingCard : Bool = false
    var choosingPlayer : Bool = false
    var chosenPlayer : Int = 0
    var currentAction : Int = 0
    var eliminated = [Int]()
    var score = [Int]()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        myBoard = BoardModel(size: numPlayers)
        score = [0, 0, 0, 0]
        nextTurn()
    }
    
    func endGame(winner: Int){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "\(nameList[winner - 1]) has won the game!"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        score[winner - 1] += 1
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "New Game"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endgame"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endgame"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func endRound(winner: Int){
        if(winner == 0){
            self.removeAllChildren()
            
            let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            bottomLabel.text = "No one won this round"
            bottomLabel.fontSize = 50
            bottomLabel.fontColor = UIColor.blackColor()
            bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(bottomLabel)
            
            let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            endLabel.text = "New Round"
            endLabel.color = UIColor.blackColor()
            endLabel.fontSize = 50
            endLabel.fontColor = UIColor.whiteColor()
            endLabel.name = "endround"
            endLabel.zPosition = 1
            endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
            
            let endBack = SKSpriteNode()
            endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
            endBack.size = CGSize(width: 300, height: 100)
            endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
            endBack.zPosition = -1
            endBack.name = "endround"
            endBack.addChild(endLabel)
            
            self.addChild(endBack)
        } else {
            self.removeAllChildren()
            
            let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            bottomLabel.text = "\(nameList[winner - 1]) has won this round"
            bottomLabel.fontSize = 50
            bottomLabel.fontColor = UIColor.blackColor()
            bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(bottomLabel)
            
            score[winner - 1] += 1
            
            let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            endLabel.text = "New Round"
            endLabel.color = UIColor.blackColor()
            endLabel.fontSize = 50
            endLabel.fontColor = UIColor.whiteColor()
            endLabel.name = "endround"
            endLabel.zPosition = 1
            endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
            
            let endBack = SKSpriteNode()
            endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
            endBack.size = CGSize(width: 300, height: 100)
            endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
            endBack.zPosition = -1
            endBack.name = "endround"
            endBack.addChild(endLabel)
            
            self.addChild(endBack)
        }
    }
    
    func nextTurn(){
        currentAction = 0
        chosenPlayer = 0
        choosingPlayer = false
        choosingCard = false
        
        self.removeAllChildren()
        
        if(eliminated.count == (numPlayers - 1)){
            
            for i in 1...numPlayers {
                if(!eliminated.contains(i)){
                    endRound(i)
                }
            }
        } else if(myBoard.deck.count <= 1){
            var newArray = [Int]()
            newArray.append(myBoard.allHands[0][0])
            newArray.append(myBoard.allHands[1][0])
            if(numPlayers == 3){
                newArray.append(myBoard.allHands[2][0])
            } else if(numPlayers == 4){
                newArray.append(myBoard.allHands[2][0])
                newArray.append(myBoard.allHands[3][0])
            }
            
            var count = 0
            
            for value in newArray {
                if(value == newArray.maxElement()){
                    count += 1
                }
            }
            
            if(count == 1){
                endRound(newArray.indexOf(newArray.maxElement()!)! + 1)
            } else {
                endRound(0)
            }
            
        } else if(score.contains(7)) {
            endGame(score.indexOf(7)! + 1)
        } else {
        
            if(myBoard.turn == numPlayers){
                myBoard.turn = 1
            } else {
                myBoard.turn += 1
            }
            
            while(eliminated.contains(myBoard.turn)){
                if(myBoard.turn == numPlayers){
                    myBoard.turn = 1
                } else {
                    myBoard.turn += 1
                }
            }
            
            print(nameList)
            
            let nextLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            nextLabel.text = "It is \(nameList[myBoard.turn - 1])'s Turn"
            nextLabel.fontSize = 50
            nextLabel.fontColor = UIColor.blackColor()
            nextLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(nextLabel)
            
            let okLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            okLabel.text = "That is Me"
            okLabel.color = UIColor.blackColor()
            okLabel.fontSize = 50
            okLabel.fontColor = UIColor.whiteColor()
            okLabel.name = "thatisme"
            okLabel.zPosition = 1
            okLabel.position = CGPoint(x: 0, y: -okLabel.frame.size.height/2)
            
            
            let okBack = SKSpriteNode()
            okBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
            okBack.size = CGSize(width: 300, height: 100)
            okBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
            okBack.zPosition = -1
            okBack.name = "thatisme"
            okBack.addChild(okLabel)
            
            self.addChild(okBack)
        }
    }
    
    func setup(data: [String]){
        numPlayers = data.count
        nameList = data
        
        for i in 0..<numPlayers {
            if(nameList[i] == ""){
                nameList[i] = "Player \(i + 1)"
            }
        }
    }
    
    func updateBoard(){
        
        // Clear Screen
        self.removeAllChildren()
        self.removeAllActions()
        choosingCard = false
        
        print("Hands: \(myBoard.allHands)")
        print("Played: \(myBoard.allPlayed)")
        print("Score: \(score)")
        
        for i in 0..<numPlayers {
            let scoreLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            scoreLabel.text = "\(nameList[i]): \(score[i])"
            scoreLabel.fontSize = 20
            scoreLabel.fontColor = UIColor.blackColor()
            scoreLabel.position = CGPoint(x: 60, y: 740 - (i * 25))
            self.addChild(scoreLabel)
        }
        
        // Place the deck
        let deck = Card(cardType: 9)
        deck.position = CGPoint(x: CGRectGetMidX(self.frame), y: 480)
        deck.size = CGSize(width: 154, height: 215)
        deck.zPosition = -1
        deck.rotateCard()
        deck.name = "deck"
        self.addChild(deck)
        
        let chooseLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        chooseLabel.text = "Draw a Card"
        chooseLabel.color = UIColor.blackColor()
        chooseLabel.fontSize = 50
        chooseLabel.fontColor = UIColor.whiteColor()
        chooseLabel.zPosition = 1
        chooseLabel.position = CGPoint(x: 0, y: -chooseLabel.frame.size.height/2)
        
        
        let chooseBack = SKSpriteNode()
        chooseBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        chooseBack.size = CGSize(width: 400, height: 100)
        chooseBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 50)
        chooseBack.zPosition = -100
        chooseBack.addChild(chooseLabel)
        
        self.addChild(chooseBack)
        
        // Place the bottom player's label
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = nameList[myBoard.turn - 1]
        bottomLabel.fontSize = 24
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 250)
        self.addChild(bottomLabel)
        
        // Place the bottom player's card
        let myCard = Card(cardType: myBoard.allHands[myBoard.turn - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 125)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "bottom"
        self.addChild(myCard)
        
        if(numPlayers == 2){
            // Place the top player's label
            let topLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            topLabel.text = nameList[myBoard.turn % numPlayers]
            topLabel.fontSize = 24
            topLabel.fontColor = UIColor.blackColor()
            topLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 570)
            self.addChild(topLabel)
            
            // Place the top player's icon
            let topCard = SKSpriteNode()
            if(self.eliminated.contains((myBoard.turn % numPlayers) + 1)){
                topCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                topCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            topCard.name = "top"
            topCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 680)
            topCard.size = CGSize(width: 200, height: 215)
            self.addChild(topCard)
        } else if(numPlayers == 3){
            // Place the left player's label
            let leftLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            leftLabel.text = nameList[myBoard.turn % numPlayers]
            leftLabel.fontSize = 24
            leftLabel.fontColor = UIColor.blackColor()
            leftLabel.position = CGPoint(x: 75, y: 285)
            self.addChild(leftLabel)
            
            // Place the left player's icon
            let leftCard = SKSpriteNode()
            if(self.eliminated.contains((myBoard.turn % numPlayers) + 1)){
                leftCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                leftCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            leftCard.name = "left"
            leftCard.position = CGPoint(x: 75, y: 400)
            leftCard.size = CGSize(width: 200, height: 215)
            self.addChild(leftCard)
            
            // Place the right player's label
            let rightLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            rightLabel.text = nameList[(myBoard.turn + 1) % numPlayers]
            rightLabel.fontSize = 24
            rightLabel.fontColor = UIColor.blackColor()
            rightLabel.position = CGPoint(x: 940, y: 285)
            self.addChild(rightLabel)
            
            // Place the right player's icon
            let rightCard = SKSpriteNode()
            if(self.eliminated.contains(((myBoard.turn + 1) % numPlayers) + 1)){
                rightCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                rightCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            rightCard.position = CGPoint(x: 940, y: 400)
            rightCard.name = "right"
            rightCard.size = CGSize(width: 200, height: 215)
            self.addChild(rightCard)
        } else if(numPlayers == 4){
            // Place the left player's label
            let leftLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            leftLabel.text = nameList[myBoard.turn % numPlayers]
            leftLabel.fontSize = 24
            leftLabel.fontColor = UIColor.blackColor()
            leftLabel.position = CGPoint(x: 75, y: 285)
            self.addChild(leftLabel)
            
            // Place the left player's icon
            let leftCard = SKSpriteNode()
            if(self.eliminated.contains((myBoard.turn % numPlayers) + 1)){
                leftCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                leftCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            leftCard.name = "left"
            leftCard.position = CGPoint(x: 75, y: 400)
            leftCard.size = CGSize(width: 200, height: 215)
            self.addChild(leftCard)
            
            // Place the top player's label
            let topLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            topLabel.text = nameList[(myBoard.turn + 1) % numPlayers]
            topLabel.fontSize = 24
            topLabel.fontColor = UIColor.blackColor()
            topLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 570)
            self.addChild(topLabel)
            
            // Place the top player's icon
            let topCard = SKSpriteNode()
            if(self.eliminated.contains(((myBoard.turn + 1) % numPlayers) + 1)){
                topCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                topCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            topCard.name = "top"
            topCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 680)
            topCard.size = CGSize(width: 200, height: 215)
            self.addChild(topCard)
            
            // Place the right player's label
            let rightLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
            rightLabel.text = nameList[(myBoard.turn + 2) % numPlayers]
            rightLabel.fontSize = 24
            rightLabel.fontColor = UIColor.blackColor()
            rightLabel.position = CGPoint(x: 940, y: 285)
            self.addChild(rightLabel)
            
            // Place the right player's icon
            let rightCard = SKSpriteNode()
            if(self.eliminated.contains(((myBoard.turn + 2) % numPlayers) + 1)){
                rightCard.texture = SKTexture(imageNamed: "PlayerIconElim.png")
            } else {
                rightCard.texture = SKTexture(imageNamed: "PlayerIcon.png")
            }
            rightCard.name = "right"
            rightCard.position = CGPoint(x: 940, y: 400)
            rightCard.size = CGSize(width: 200, height: 215)
            self.addChild(rightCard)
        }
    }
    
    func playBatman(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "Guess their card:"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 650)
        self.addChild(bottomLabel)
        
        var myCard = Card(cardType: 2)
        myCard.position = CGPoint(x: (CGRectGetMidX(self.frame) / 2), y: 500)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 3)
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 500)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 4)
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame) + (CGRectGetMidX(self.frame) / 2), y: 500)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 5)
        myCard.position = CGPoint(x: (CGRectGetMaxX(self.frame) / 5), y: 250)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 6)
        myCard.position = CGPoint(x: (CGRectGetMaxX(self.frame) / 5) * 2, y: 250)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 7)
        myCard.position = CGPoint(x: (CGRectGetMaxX(self.frame) / 5) * 3, y: 250)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
        myCard = Card(cardType: 8)
        myCard.position = CGPoint(x: (CGRectGetMaxX(self.frame) / 5) * 4, y: 250)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "guess"
        self.addChild(myCard)
        
    }
    
    func playCatwoman(){
        
        print(myBoard.allHands[chosenPlayer - 1][0])
        
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "\(nameList[chosenPlayer - 1])'s Card:"
        bottomLabel.fontSize = 24
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 550)
        self.addChild(bottomLabel)
        
        let myCard = Card(cardType: myBoard.allHands[chosenPlayer - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 400)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "card"
        self.addChild(myCard)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playBane(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "VS"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        var myCard = Card(cardType: myBoard.allHands[myBoard.turn - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame) / 2, y: CGRectGetMidY(self.frame))
        myCard.size = CGSize(width: 154, height: 215)
        self.addChild(myCard)
        
        myCard = Card(cardType: myBoard.allHands[chosenPlayer - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame) + (CGRectGetMidX(self.frame) / 2), y: CGRectGetMidY(self.frame))
        myCard.size = CGSize(width: 154, height: 215)
        self.addChild(myCard)
        
        let resultsLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        resultsLabel.text = "RESULTS"
        resultsLabel.fontSize = 50
        resultsLabel.fontColor = UIColor.blackColor()
        resultsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 600)
        self.addChild(resultsLabel)
        
        if(myBoard.allHands[myBoard.turn - 1][0] > myBoard.allHands[chosenPlayer - 1][0]){
            resultsLabel.text = "\(nameList[myBoard.turn - 1]) defeated \(nameList[chosenPlayer - 1])"
            eliminated.append(chosenPlayer)
            myBoard.allPlayed[chosenPlayer - 1].append(0)
        } else if(myBoard.allHands[myBoard.turn - 1][0] < myBoard.allHands[chosenPlayer - 1][0]) {
            resultsLabel.text = "\(nameList[chosenPlayer - 1]) defeated \(nameList[myBoard.turn - 1])"
            eliminated.append(myBoard.turn)
            myBoard.allPlayed[chosenPlayer - 1].append(0)
        } else {
            resultsLabel.text = "DRAW"
        }
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playRobin(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "Robin is protecting you"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playPoisonivy(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "\(nameList[chosenPlayer - 1]) discarded a:"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 600)
        self.addChild(bottomLabel)
        
        let myCard = Card(cardType: myBoard.allHands[chosenPlayer - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 400)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "card"
        self.addChild(myCard)
        
        if(myBoard.allHands[chosenPlayer - 1][0] == 8){
            eliminated.append(chosenPlayer)
            myBoard.allPlayed[chosenPlayer - 1].append(myBoard.allHands[chosenPlayer - 1].popLast()!)
            myBoard.allPlayed[chosenPlayer - 1].append(0)
        } else if(myBoard.allHands[chosenPlayer - 1][0] == 4) {
            myBoard.allPlayed[chosenPlayer - 1].append(myBoard.allHands[chosenPlayer - 1].popLast()!)
            myBoard.allHands[chosenPlayer - 1].append(myBoard.deck.popLast()!)
            myBoard.allPlayed[chosenPlayer - 1].append(0)
        } else {
            myBoard.allPlayed[chosenPlayer - 1].append(myBoard.allHands[chosenPlayer - 1].popLast()!)
            myBoard.allHands[chosenPlayer - 1].append(myBoard.deck.popLast()!)
        }
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playTwoface(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "You just got this card from \(nameList[chosenPlayer - 1]):"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: 600)
        self.addChild(bottomLabel)
        
        let myCard = Card(cardType: myBoard.allHands[chosenPlayer - 1][0])
        myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 400)
        myCard.size = CGSize(width: 154, height: 215)
        myCard.name = "card"
        self.addChild(myCard)
        
        let card1 = myBoard.allHands[chosenPlayer - 1].popLast()
        myBoard.allHands[chosenPlayer - 1].append(myBoard.allHands[myBoard.turn - 1].popLast()!)
        myBoard.allHands[myBoard.turn - 1].append(card1!)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playHarley(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "Harley Quinn has no effect"
        bottomLabel.fontSize = 50
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playJoker(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "You have let Joker loose. You are Eliminated"
        bottomLabel.fontSize = 40
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        eliminated.append(myBoard.turn)
        myBoard.allPlayed[myBoard.turn - 1].append(0)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func playedYourself(){
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "Everyone was protected, so you used your card on yourself"
        bottomLabel.fontSize = 24
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    func forcedHarley() {
        self.removeAllChildren()
        
        let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        bottomLabel.text = "Harley Quinn didn't like who she was with and discarded herself"
        bottomLabel.fontSize = 24
        bottomLabel.fontColor = UIColor.blackColor()
        bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(bottomLabel)
        
        let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
        endLabel.text = "End Turn"
        endLabel.color = UIColor.blackColor()
        endLabel.fontSize = 50
        endLabel.fontColor = UIColor.whiteColor()
        endLabel.name = "endturn"
        endLabel.zPosition = 1
        endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
        
        let endBack = SKSpriteNode()
        endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
        endBack.size = CGSize(width: 300, height: 100)
        endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
        endBack.zPosition = -1
        endBack.name = "endturn"
        endBack.addChild(endLabel)
        
        self.addChild(endBack)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = nodeAtPoint(location)
            
            switch node.name {
            case "thatisme"?:
                updateBoard()
            case "deck"?:
                if(!choosingCard && !choosingPlayer){
                    
                    let chooseLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
                    chooseLabel.text = "Choose a Card"
                    chooseLabel.color = UIColor.blackColor()
                    chooseLabel.fontSize = 50
                    chooseLabel.fontColor = UIColor.whiteColor()
                    chooseLabel.zPosition = 1
                    chooseLabel.name = "chooseacard"
                    chooseLabel.position = CGPoint(x: 0, y: -chooseLabel.frame.size.height/2)
                    
                    
                    let chooseBack = SKSpriteNode()
                    chooseBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
                    chooseBack.size = CGSize(width: 400, height: 100)
                    chooseBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) - 50)
                    chooseBack.zPosition = 0
                    chooseBack.name = "chooseback"
                    chooseBack.addChild(chooseLabel)
                    
                    self.addChild(chooseBack)
                    
                    choosingCard = true
                    let myCard = Card(cardType: myBoard.deck.popLast()!)
                    
                    myBoard.allHands[myBoard.turn - 1].append(myCard.cardType)
                    
                    myCard.position = CGPoint(x: CGRectGetMidX(self.frame), y: 400)
                    myCard.size = CGSize(width: 154, height: 215)
                    myCard.zPosition = 200
                    myCard.moveToSelect()
                    myCard.name = "card"
                    
                    (self.childNodeWithName("bottom") as! Card).moveToRight()
                    self.childNodeWithName("bottom")!.name = "card"
                    self.addChild(myCard)
                    
                    if((myBoard.allHands[myBoard.turn - 1].contains(7) && myBoard.allHands[myBoard.turn - 1].contains(6)) || (myBoard.allHands[myBoard.turn - 1].contains(7) && myBoard.allHands[myBoard.turn - 1].contains(5))) {
                        choosingCard = false
                        myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(7)!)
                        myBoard.allPlayed[myBoard.turn - 1].append(7)
                        forcedHarley()
                    }
                    
                    
                }
            case "card"?:
                if(choosingCard){
                    var count = 0
                    for i in 0..<numPlayers {
                        if(myBoard.turn - 1 != i){
                            if(myBoard.allPlayed[i].last == 4 || myBoard.allPlayed[i].last == 0) {
                                count += 1
                            }
                        }
                    }
                    
                    print("Count: \(count)")
                    
                    if(count == numPlayers - 1){
                        print("It's just you man")
                        switch (node as! Card).cardType {
                        case 1:
                            print("Batman")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(1)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(1)
                            
                            playedYourself()
                        case 2:
                            print("Catwoman")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(2)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(2)
                            
                            playedYourself()
                        case 3:
                            print("Bane")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(3)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(3)
                            
                            playedYourself()
                        case 4:
                            print("Robin")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(4)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(4)
                            
                            currentAction = 4
                            choosingCard = false
                            choosingPlayer = false
                            
                            playRobin()
                        case 5:
                            print("Poison Ivy")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(5)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(5)
                            
                            chosenPlayer = myBoard.turn
                            print("You just discarded your card because everyone is protected")
                            playPoisonivy()
                            
                        case 6:
                            print("Two Face")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(6)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(6)
                            
                            playedYourself()
                        case 7:
                            print("Harley Quinn")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(7)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(7)
                            
                            currentAction = 7
                            choosingCard = false
                            choosingPlayer = false
                            playHarley()
                        case 8:
                            print("Joker")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(8)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(8)
                            
                            currentAction = 8
                            choosingCard = false
                            choosingPlayer = false
                            
                            playJoker()
                        default: ()
                        }
                    } else {
                        switch (node as! Card).cardType {
                        case 1:
                            print("Batman")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(1)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(1)
                            
                            currentAction = 1
                            choosingCard = false
                            choosingPlayer = true
                            
                            (self.childNodeWithName("chooseback")?.childNodeWithName("chooseacard") as! SKLabelNode).text = "Choose a Player"
                            
                        case 2:
                            print("Catwoman")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(2)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(2)
                            
                            currentAction = 2
                            choosingCard = false
                            choosingPlayer = true
                            
                            (self.childNodeWithName("chooseback")?.childNodeWithName("chooseacard") as! SKLabelNode).text = "Choose a Player"
                        case 3:
                            print("Bane")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(3)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(3)
                            
                            currentAction = 3
                            choosingCard = false
                            choosingPlayer = true
                            
                            (self.childNodeWithName("chooseback")?.childNodeWithName("chooseacard") as! SKLabelNode).text = "Choose a Player"
                        case 4:
                            print("Robin")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(4)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(4)
                            
                            currentAction = 4
                            choosingCard = false
                            choosingPlayer = false
                            
                            playRobin()
                        case 5:
                            print("Poison Ivy")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(5)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(5)
                            
                            currentAction = 5
                            choosingCard = false
                            choosingPlayer = true
                            
                            (self.childNodeWithName("chooseback")?.childNodeWithName("chooseacard") as! SKLabelNode).text = "Choose a Player"
                        case 6:
                            print("Two Face")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(6)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(6)
                            
                            currentAction = 6
                            choosingCard = false
                            choosingPlayer = true
                            
                            (self.childNodeWithName("chooseback")?.childNodeWithName("chooseacard") as! SKLabelNode).text = "Choose a Player"
                        case 7:
                            print("Harley Quinn")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(7)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(7)
                            
                            currentAction = 7
                            choosingCard = false
                            choosingPlayer = false
                            playHarley()
                        case 8:
                            print("Joker")
                            myBoard.allHands[myBoard.turn - 1].removeAtIndex(myBoard.allHands[myBoard.turn - 1].indexOf(8)!)
                            myBoard.allPlayed[myBoard.turn - 1].append(8)
                            
                            currentAction = 8
                            choosingCard = false
                            choosingPlayer = false
                            
                            playJoker()
                        default: ()
                        }
                    }
                }
            case "top"?:
                if(choosingPlayer){
                    switch numPlayers {
                    case 2:
                        chosenPlayer = (myBoard.turn % numPlayers) + 1
                        print("ChosenPlayer: \(chosenPlayer)")
                    case 4:
                        chosenPlayer = ((myBoard.turn % numPlayers) + 2) % numPlayers
                        if(chosenPlayer == 0){
                            chosenPlayer = 4
                        }
                        print("ChosenPlayer: \(chosenPlayer)")
                    default: ()
                    }
                    
                    if(myBoard.allPlayed[chosenPlayer - 1].last == 4){
                        chosenPlayer = 0
                        print("That person is protected")
                    } else if(eliminated.contains(chosenPlayer)) {
                        chosenPlayer = 0
                        print("That player is eliminated")
                    } else {
                    
                        switch currentAction {
                        case 1:
                            playBatman()
                        case 2:
                            playCatwoman()
                        case 3:
                            playBane()
                        case 4:
                            playRobin()
                        case 5:
                            playPoisonivy()
                        case 6:
                            playTwoface()
                        case 7:
                            playHarley()
                        case 8:
                            playJoker()
                        default: ()
                        }
                    }
                }
            case "left"?:
                if (choosingPlayer){
                    switch numPlayers {
                    case 3:
                        chosenPlayer = (myBoard.turn % numPlayers) + 1
                        print("ChosenPlayer: \(chosenPlayer)")
                    case 4:
                        chosenPlayer = (myBoard.turn % numPlayers) + 1
                        print("ChosenPlayer: \(chosenPlayer)")
                    default: ()
                    }
                    
                    if(myBoard.allPlayed[chosenPlayer - 1].last == 4){
                        chosenPlayer = 0
                        print("That person is protected")
                    } else if(eliminated.contains(chosenPlayer)) {
                        chosenPlayer = 0
                        print("That player is eliminated")
                    } else {
                        switch currentAction {
                        case 1:
                            playBatman()
                        case 2:
                            playCatwoman()
                        case 3:
                            playBane()
                        case 4:
                            playRobin()
                        case 5:
                            playPoisonivy()
                        case 6:
                            playTwoface()
                        case 7:
                            playHarley()
                        case 8:
                            playJoker()
                        default: ()
                        }
                    }
                }
            case "right"?:
                if (choosingPlayer){
                    switch numPlayers {
                    case 3:
                        chosenPlayer = ((myBoard.turn % numPlayers) + 2) % numPlayers
                        if(chosenPlayer == 0){
                            chosenPlayer = 3
                        }
                        print("ChosenPlayer: \(chosenPlayer)")
                    case 4:
                        chosenPlayer = ((myBoard.turn % numPlayers) + 3) % numPlayers
                        if(chosenPlayer == 0){
                            chosenPlayer = 4
                        }
                        print("ChosenPlayer: \(chosenPlayer)")
                    default: ()
                    }
                    
                    if(myBoard.allPlayed[chosenPlayer - 1].last == 4){
                        chosenPlayer = 0
                        print("That person is protected")
                    } else if(eliminated.contains(chosenPlayer)) {
                        chosenPlayer = 0
                        print("That player is eliminated")
                    } else {
                        switch currentAction {
                        case 1:
                            playBatman()
                        case 2:
                            playCatwoman()
                        case 3:
                            playBane()
                        case 4:
                            playRobin()
                        case 5:
                            playPoisonivy()
                        case 6:
                            playTwoface()
                        case 7:
                            playHarley()
                        case 8:
                            playJoker()
                        default: ()
                        }
                    }
                }
            case "endturn"?:
                nextTurn()
            case "guess"?:
                self.removeAllChildren()
                
                let bottomLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
                bottomLabel.text = "Correct! \(nameList[chosenPlayer - 1]) has been returned to Arkham!"
                bottomLabel.fontSize = 40
                bottomLabel.fontColor = UIColor.blackColor()
                bottomLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
                self.addChild(bottomLabel)
                
                let endLabel = SKLabelNode(fontNamed:"AmericanTypewriter")
                endLabel.text = "End Turn"
                endLabel.color = UIColor.blackColor()
                endLabel.fontSize = 50
                endLabel.fontColor = UIColor.whiteColor()
                endLabel.name = "endturn"
                endLabel.zPosition = 1
                endLabel.position = CGPoint(x: 0, y: -endLabel.frame.size.height/2)
                
                
                let endBack = SKSpriteNode()
                endBack.texture = SKTexture(imageNamed: "BlackBack.jpg")
                endBack.size = CGSize(width: 300, height: 100)
                endBack.position = CGPoint(x: CGRectGetMidX(self.frame), y: 150)
                endBack.zPosition = -1
                endBack.name = "endturn"
                endBack.addChild(endLabel)
                
                self.addChild(endBack)
                
                if(myBoard.allHands[chosenPlayer - 1][0] == (node as! Card).cardType){
                    eliminated.append(chosenPlayer)
                    myBoard.allPlayed[chosenPlayer - 1].append(0)
                    self.score[myBoard.turn - 1] += 1
                }
                else{
                    bottomLabel.text = "Incorrect!"
                }
            case "endround"?:
                print("new round")
                self.eliminated = [Int]()
                myBoard = BoardModel(size: numPlayers)
                nextTurn()
            case "endgame"?:
                print("new game")
                self.eliminated = [Int]()
                score = [0, 0, 0, 0]
                myBoard = BoardModel(size: numPlayers)
                nextTurn()
            default: ()
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
