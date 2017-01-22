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
        "playing.5":"Get as many tricks as you can!"
    ]
