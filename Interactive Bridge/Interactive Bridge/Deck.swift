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
    case TWO_EACH_SUIT, ACE_EACH_SUIT, NO_CLUBS
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
    
    mutating func remove(card: Card) {
        cards.remove(at: cards.index(of: card)!)
    }
    
    func peek() -> Card {
        return cards[0]
    }
    
    mutating func deal(players: Int = 4, special: handReqs?) -> [Hand] {
        // ensure that cards are divisible by playerCount
        if cards.count % 4 != 0 {
            return []
        }
        var hands = [Hand]()
        for _ in 0..<players {
            hands.append(Hand.init([Card]()))
        }
        if special == nil {
            shuffle()
            while(cards.count > 0) {
                for playerIndex in 0..<players {
                    hands[playerIndex].addCard(card: draw())
                }
            }
        }
        else {
            switch(special!) {
            case .TWO_EACH_SUIT:
                repeat {
                    reshuffle()
                    shuffle()
                    for hand in hands {
                        hand.removeAll()
                    }
                    while(cards.count > 0) {
                        for playerIndex in 0..<players {
                            hands[playerIndex].addCard(card: draw())
                        }
                    }
                }
                while (hands[0].cardsIn(suit: Suit.spades) <= 2 || hands[0].cardsIn(suit: Suit.hearts) <= 2 || hands[0].cardsIn(suit: Suit.diamonds) <= 2 || hands[0].cardsIn(suit: Suit.clubs) <= 2 )
                return hands
            case .ACE_EACH_SUIT:
                shuffle()
                for suit in Suit.allValues {
                    let card = Card.init(rank: .ace, suit: suit)
                    hands[0].addCard(card: card)
                    remove(card: card)
                }
                for _ in 1...4 {
                    for playerIndex in 1..<players {
                        hands[playerIndex].addCard(card: draw())
                    }
                }
                while(cards.count > 0) {
                    for playerIndex in 0..<players {
                        hands[playerIndex].addCard(card: draw())
                    }
                }
                return hands
            case .NO_CLUBS:
                shuffle()
                for _ in 1...13 {
                    let i = cards.index(where: { $0.Suit == .clubs })!
                    let playerIndex = Int(arc4random_uniform(3)) + 1
                    hands[playerIndex].addCard(card: cards[i])
                    cards.remove(at: i)
                }
                for _ in 1...13 {
                    hands[0].addCard(card: draw())
                }
                // assumes 52 cards, 4 players
                for playerIndex in 0..<players {
                    if hands[playerIndex].cards.count < 13 {
                        hands[playerIndex].addCard(card: draw())
                    }
                }
                return hands
            }
        }
        return hands
    }
}
