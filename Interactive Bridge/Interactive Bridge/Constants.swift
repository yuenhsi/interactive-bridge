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

var Rules: Dictionary<String, String> =
    [
        "playing.1":"The aim of Bridge is to win as many Tricks as possible between you and your partner, who sits opposite you. There are 13 tricks per game, one for every card in the players' hand.",
        "playing.2":"The person who leads decides the suit everyone must follow as the play moves clockwise around the table.",
        "playing.3":"The person who plays the highest card in the decided suit wins the trick, unless there is a trump suit.",
        "playing.4":"If there is a trump suit in play, the person who played the highest trump card wins the trick.",
        "playing.4":"The person who wins the trick gets to lead the next round.",
        "playing.5":"Get as many tricks as you can!",
        
        "bidding.1":"As you may realize, whoever gets to decide the trump suit starts with an advantage. Bidding is how the trump gets decided. Suits are ranked; NT(No trump) is the highest, followed by Spades, Hearts, Diamonds, and finally Clubs.",
        "bidding.2":"The dealer starts the bid, others follow in a clockwise manner. A dealer may pass, or bid. A bid starts with a number between 1 to 7, which is the number of tricks in addition to 6 the bidder agrees to win, and a suit. For example, a bid of 2 clubs means the bidder intends to win 8(6+2) tricks, where clubs is the trump suit",
        "bidding.3":"You can respond to a bid by passing, or bidding something higher. For example, you can respond to a bid of 2 Clubs with 2 Spades (Remember that Spades > Clubs!). You can also Double an opponent's bet if you are confident you can stop them from making their bid, which doubles the stakes. Be wary, though, as your opponents may ReDouble to up the stakes 4x!",
        "bidding.4":"Keep in mind that the person sitting opposite you is your partner - if your partner makes a bid you're not confident in making, you can change the bet when it's your turn as a way to communicate your cards with him.",
        "bidding.5":"When a player makes a bid where everyone else passes, the game starts. The person opposite the bidder becomes the Dummy, and lays his cards down for everyone to see. The bidder leads, and gets to play for both himself and the Dummy. Good luck!"
    ]
