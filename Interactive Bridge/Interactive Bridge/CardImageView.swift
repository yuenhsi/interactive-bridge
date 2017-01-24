//
//  CardImageView.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/24/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class CardImageView: UIImageView {

    var card: Card? {
        didSet {
            if card != nil {
                self.image = UIImage(named: getCardImageName(card!))
            } else {
                self.image = UIImage(named: "cardBack")
            }
        }
    }
    
    func setCard(_ card: Card) {
        
        self.card = card
        
    }
    
    func setLabel(labelText: String) {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width))
        label.center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        label.textAlignment = .center
        label.text = labelText
        label.textColor = UIColor.red
        label.font = UIFont(name: "AvenirNext-Heavy", size: 40)
        
    }
    
}
