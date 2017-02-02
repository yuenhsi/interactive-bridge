//
//  SmartBridgePlayer.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation
import GameplayKit

func playRound(lead: Position, hands: [Hand]) -> [(position: Int, card: Card)] {
    var round = [(Int, Card)]()
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
        return round
    }
    for playerIndex in startingPosition ... 3 {
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
        round.append((playerIndex, card))
    }
    return round
}


func finishRound(round: [(position: Int, card: Card)], hands: [Hand]) -> [(position: Int, card: Card)] {
    guard round.count >= 1 else {
        print("finishRound called with empty round passed in")
        return round
    }
    var completedRound = round
    let playsLeft = 4 - round.count
    let selectedSuit = round[0].card.Suit
    
    // finishRound always starts from position 1, where west hand is
    for position in 1...playsLeft {
        var card: Card
        if let i = hands[position].cards.index(where: { $0.Suit == selectedSuit }) {
            card = hands[position].cards[i]
        } else {
            card = hands[position].cards[0]
        }
        completedRound.append((position, card))
    }
    return completedRound
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


func getPositionFromNumber(number: Int, playerPosition: Position) -> Position {
    var position = number
    switch (playerPosition) {
    case .west:
        position += 1
    case .north:
        position += 2
    case .east:
        position += 3
    default:
        break
    }
    switch (position % 4) {
    case 0:
        return Position.south
    case 1:
        return Position.west
    case 2:
        return Position.north
    case 3:
        return Position.east
    default:
        print("something wrong happened... switch on mod 4 not returning 0-3")
        return Position.south
    }
}

func randomSuit() -> Suit {
    return GKRandomSource.sharedRandom().arrayByShufflingObjects(in: [Suit.clubs, Suit.diamonds, Suit.hearts, Suit.spades])[0]
}
