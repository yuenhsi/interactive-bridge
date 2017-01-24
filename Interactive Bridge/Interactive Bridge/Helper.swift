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

func getCardImageName(_ card: Card) -> String {
    return "card\(card.Suit.rawValue)\(card.Rank.rawValue)"
}
