//
//  SmartBridgePlayer.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation

func playRound(lead: Position, hands: inout [Hand]) -> [Card] {
    var playedCards = [Card]()
    var startingPosition: Int!
    switch lead {
    case .west:
        startingPosition = 1
    case .north:
        startingPosition = 2
    case .east:
        startingPosition = 3
    case .south:
        return playedCards
    }
    var selectedSuit: Suit!
    for player in startingPosition ... 4 - startingPosition {
        // check whether this player is leading
        var card: Card
        if player == startingPosition {
            card = hands[player].cards.remove(at: 0)
            selectedSuit = card.Suit
        } else {
            // just play a random card of correct suit, or a random card for now
            if let i = hands[player].cards.index(where: { $0.Suit == selectedSuit }) {
                card = hands[player].cards.remove(at: i)
            } else {
                // not very intelligent for now...
                card = hands[player].cards.remove(at: 0)
            }
        }
        playedCards.append(card)
    }
    return playedCards
}

// stub, for continuation after player plays his card
func finishRound() {
    
}
