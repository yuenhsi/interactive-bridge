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
                let cardImg = UIImage(named: getCardImageName(card))
                let cardImage = CardImageView(image: cardImg)
                cardImage.contentMode = .scaleAspectFit
                self.addArrangedSubview(cardImage)
            }
        } else {
            for _ in 1...13 {
                let cardImg = UIImage(named: "cardBack")
                let cardImage = CardImageView(image: cardImg)
                cardImage.contentMode = .scaleAspectFit
                self.addArrangedSubview(cardImage)
            }
        }
    }

}
