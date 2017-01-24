//
//  Helper.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/23/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import GameplayKit
import Foundation

func sortCardsBySuit(first: Card, second: Card) -> Bool {
    if first.Suit == second.Suit {
        return first.Rank.hashValue > second.Rank.hashValue
    } else {
        return first.Suit.hashValue > second.Suit.hashValue
    }
}

func playRound(lead: Position, hands: inout [[Card]]) -> [Card] {
    var startingPosition: Int!
    switch lead {
    case .west:
        startingPosition = 1
    case .north:
        startingPosition = 2
    case .east:
        startingPosition = 3
    case .south:
        return [Card]()
    }
//    let card = hands[startingPosition].remove(at: 0)
    
    return [Card]()
}
