//
//  SmartBridgePlayer.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation

func playRound(lead: Position, hands: [Hand]) -> [(position: Int, card: Card)] {
    var plays = [(Int, Card)]()
    var selectedSuit: Suit!
    var startingPosition: Int!
    switch lead {
    case .west:
        startingPosition = 1
    case .north:
        startingPosition = 2
    case .east:
        startingPosition = 3
    case .south:
        return plays
    }
    for playerIndex in startingPosition ... 4 - startingPosition {
        // check whether this player is leading
        var card: Card
        if playerIndex == startingPosition {
            card = hands[playerIndex].cards[0]
            selectedSuit = card.Suit
        } else {
            // just play a random card of correct suit, or a random card for now
            if let i = hands[playerIndex].cards.index(where: { $0.Suit == selectedSuit }) {
                card = hands[playerIndex].cards[i]
            } else {
                // not very intelligent for now...
                card = hands[playerIndex].cards[0]
            }
        }
        plays.append((playerIndex, card))
    }
    return plays
}

// stub, for continuation after player plays his card
func finishRound() {
    
}

func getRoundWinner(round: [(position: Int, card: Card)], trump: Suit?) -> Int {
    
    var winner = round[0].position
    var winnerCard = round[0].card
    
    for i in 1...3 {
        if round[i].card.Suit == winnerCard.Suit {
            if round[i].card.Rank > winnerCard.Rank {
                winnerCard = round[i].card
                winner = round[i].position
            }
        } else {
            if round[i].card.Suit == trump {
                winnerCard = round[i].card
                winner = round[i].position
            }
        }
    }
    return winner
}
