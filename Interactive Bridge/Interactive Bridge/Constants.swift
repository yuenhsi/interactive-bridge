//
//  Constants.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/22/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import Foundation

enum Tutorial: String {
    case playing, bidding, scoring
}

enum Position: String {
    case north = "North", south = "South", east = "East", west = "West"
}

let playingRules =
    [
        "The aim of Bridge is to win as many Tricks as possible between you and your partner, who sits opposite you. There are 13 tricks per game, one for every card in each players' hand.",
        "The person who leads decides the suit everyone must follow as the play moves clockwise around the table.",
        "The person who plays the highest card in the decided suit wins the trick, unless there is a trump suit. The winner then leads. Win the trick, then lead!",
        "If there is a trump suit in play, the person who played the highest trump card wins the trick.",
        "Get as many tricks as you can!"
    ]

let biddingRules =
    [
        "As you may realize, whoever gets to decide the trump suit starts with an advantage. Bidding is how the trump gets decided. Suits are ranked; NT(No trump) is the highest, followed by Spades, Hearts, Diamonds, and finally Clubs.",
        "The dealer starts the bid, others follow in a clockwise manner. A dealer may pass, or bid. A bid starts with a number between 1 to 7, which is the number of tricks in addition to 6 the bidder agrees to win, and a suit. For example, a bid of 2 clubs means the bidder intends to win 8(6+2) tricks, where clubs is the trump suit",
        "You can respond to a bid by passing, or bidding something higher. For example, you can respond to a bid of 2 Clubs with 2 Spades (Remember that Spades > Clubs!). You can also Double an opponent's bet if you are confident you can stop them from making their bid, which doubles the stakes. Be wary, though, as your opponents may ReDouble to up the stakes 4x!",
        "Keep in mind that the person sitting opposite you is your partner - if your partner makes a bid you're not confident in making, you can change the bet when it's your turn as a way to communicate your cards with him.",
        "When a player makes a bid where everyone else passes, the game starts. The person opposite the bidder becomes the Dummy, and lays his cards down for everyone to see. The bidder leads, and gets to play for both himself and the Dummy. Good luck!"
    ]
