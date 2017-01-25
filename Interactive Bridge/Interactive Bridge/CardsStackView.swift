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
                cardImage.contentMode = .scaleAspectFit
                cardImage.isUserInteractionEnabled = true
                self.addArrangedSubview(cardImage)
            }
        } else {
            for tag in 1...13 {
                let cardImage = CardImageView()
                cardImage.setCard(nil)
                cardImage.contentMode = .scaleAspectFit
                cardImage.tag = tag
                cardImage.isUserInteractionEnabled = true
                self.addArrangedSubview(cardImage)
            }
        }
    }

}
