//
//  CardsStackView.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class CardsStackView: UIStackView {
    
    func refreshCards(_ cards: [Card]) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        if (cards.count != 0) {
            for card in cards {
                let cardImage = CardImageView()
                cardImage.setCard(card)
                self.addArrangedSubview(cardImage)
            }
        }
    }
    
    func removeCard(card: Card) {
        let subviews = self.subviews.filter { ($0 as! CardImageView).card == card }
        subviews[0].removeFromSuperview()
    }

}
