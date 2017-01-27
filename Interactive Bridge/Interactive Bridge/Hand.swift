//
//  Hand.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/26/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation

class Hand {
    
    var cards: [Card]!
    
    init(_ cards: [Card]) {
        self.cards = cards
        self.cards.sort { sortCardsBySuit(first: $0, second: $1) }
    }
    
    func sortCardsBySuit(first: Card, second: Card) -> Bool {
        if first.Suit == second.Suit {
            return first.Rank.hashValue > second.Rank.hashValue
        } else {
            return first.Suit.hashValue > second.Suit.hashValue
        }
    }

    func cardsIn(suit: Suit) -> Int {
        return (cards.filter { $0.Suit ==  suit }).count
    }
    
    func addCard(card: Card) {
        self.cards.append(card)
    }
    
    func sort() {
        self.cards.sort { sortCardsBySuit(first: $0, second: $1) }
    }
    
    func removeAll() {
        self.cards.removeAll()
    }
}
