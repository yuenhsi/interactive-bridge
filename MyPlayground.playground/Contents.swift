//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Deck {
    func giveCard() -> Card {
        return Card(rank: "ace", suit: "hearts")
    }
}

class Card {
    var Rank: String
    var Suit: String
    
    init(rank: String, suit: String) {
        self.Rank = rank
        self.Suit = suit
    }
}

var myDeck = Deck()
var newCard = myDeck.giveCard()
newCard.Rank = "fd"
print(newCard.Rank)