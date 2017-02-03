//
//  CardsStackView.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class CardsStackView: UIStackView {
    
    func refreshCards(_ hand: Hand) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        for card in hand.cards {
            let cardImage = CardImageView()
            cardImage.setCard(card)
            self.addArrangedSubview(cardImage)
        }
    }
    
    func removeCard(card: Card) {
        let subviews = self.subviews.filter { ($0 as! CardImageView).card == card }
        subviews[0].removeFromSuperview()
    }
    
    func removeCard() {
        self.subviews[0].removeFromSuperview()
    }
    
    func updateFaceDown(rotated: Bool) {
        while self.subviews.count < 13 {
            let cardImage = CardImageView()
            cardImage.setFacedownCard(rotated: rotated)
            self.addArrangedSubview(cardImage)
        }
    }
    
    func refreshFaceDown() {
        self.subviews.forEach({ $0.removeFromSuperview() })
        for _ in 1...13 {
            let faceDownCard = CardImageView()
            faceDownCard.setFacedownCard(rotated: false)
            self.addArrangedSubview(faceDownCard)
        }
    }

}
