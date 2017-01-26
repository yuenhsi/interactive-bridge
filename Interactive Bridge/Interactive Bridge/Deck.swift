//
//  Deck.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/23/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation
import GameplayKit

struct Deck {
    
    var cards = [Card]()
    
    init?() {
        for rank in Rank.allValues {
            for suit in Suit.allValues {
                let card = Card.init(rank: rank, suit: suit)
                cards.append(card)
            }
        }
    }
    
    mutating func shuffle() {
        self.cards = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: cards) as! [Card]
    }
    
    mutating func draw() -> Card {
        return cards.remove(at: 0)
    }
    
    mutating func burn() {
        cards.remove(at: 0)
    }
    
    func peek() -> Card {
        return cards[0]
    }
    
    mutating func deal(players: Int = 4) -> [[Card]] {
        // this func breaks if cards.count is not divisible by the number of players
        var hands = [[Card]]()
        for _ in 0..<players {
            hands.append([Card]())
        }
        while(cards.count > 0) {
            for playerIndex in 0..<players {
                hands[playerIndex].append(draw())
            }
        }
        return hands
    }
}
