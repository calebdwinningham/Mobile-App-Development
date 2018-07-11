//
//  BoardModel.swift
//  Love Letter New
//
//  Created by T5A User on 11/28/16.
//  Copyright © 2016 USAFA. All rights reserved.
//

import Foundation
import UIKit

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

class BoardModel {
    var numPlayers = 4
        
    var deck = [Int]()
    var p1Hand = [Int]()
    var p2Hand = [Int]()
    var p3Hand = [Int]()
    var p4Hand = [Int]()
    var allHands = [[Int]]()
    
    var allPlayed = [[Int]]()
    
    var turn = Int()
        
    init(size: Int) {
        self.numPlayers = size
        self.deck = [1, 1, 1, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 8]
        self.deck.shuffleInPlace()
        
        self.p1Hand.append(self.deck.popLast()!)
        self.p2Hand.append(self.deck.popLast()!)
        
        if(size == 3){
            self.p3Hand.append(self.deck.popLast()!)
        }
        else if(size == 4){
            self.p3Hand.append(self.deck.popLast()!)
            self.p4Hand.append(self.deck.popLast()!)
        }
        
        allHands.append(p1Hand)
        allHands.append(p2Hand)
        allHands.append(p3Hand)
        allHands.append(p4Hand)
        
        allPlayed.append([Int]())
        allPlayed.append([Int]())
        allPlayed.append([Int]())
        allPlayed.append([Int]())
        
        self.turn = 0
        
    }
}