//
//  Deck.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/23/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation
import GameplayKit

enum handReqs {
    case TWO_EACH_SUIT, ACE_EACH_SUIT
}

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
    
    mutating func reshuffle() {
        cards.removeAll()
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
    
    mutating func deal(players: Int = 4, special: handReqs?) -> [Hand] {
        // ensure that cards are divisible by playerCount
        if cards.count % 4 != 0 {
            return []
        }
        shuffle()
        var hands = [Hand]()
        for _ in 0..<players {
            hands.append(Hand.init([Card]()))
        }
        while(cards.count > 0) {
            for playerIndex in 0..<players {
                hands[playerIndex].addCard(card: draw())
            }
        }
        if special != nil {
            switch(special!) {
            case .TWO_EACH_SUIT:
                while hands[0].cardsIn(suit: Suit.spades) <= 2 || hands[0].cardsIn(suit: Suit.hearts) <= 2 || hands[0].cardsIn(suit: Suit.diamonds) <= 2 || hands[0].cardsIn(suit: Suit.clubs) <= 2 {
                    for hand in hands {
                        hand.removeAll()
                    }
                    reshuffle()
                    shuffle()
                    while(cards.count > 0) {
                        for playerIndex in 0..<players {
                            hands[playerIndex].addCard(card: draw())
                        }
                    }
                }
                return hands
            case .ACE_EACH_SUIT:
                return hands
            }
        }
        return hands
    }
}
