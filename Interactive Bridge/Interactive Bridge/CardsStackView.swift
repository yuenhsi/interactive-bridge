//
//  CardsStackView.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class CardsStackView: UIStackView {

    func redraw() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func addCards(_ cards: [Card]) {
        for card in cards {
            let cardImg = UIImage(named: getCardImageName(card))
            let cardImage = CardImageView(image: cardImg)
            cardImage.contentMode = .scaleAspectFit
            self.addArrangedSubview(cardImage)
        }
    }

}
