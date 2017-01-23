//
//  TutorialVC.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/22/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class PlayingVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ruleLbl: UILabel!
    @IBOutlet weak var selectedSuitImg: UIImageView!
    @IBOutlet weak var trumpSuitImg: UIImageView!
    @IBOutlet weak var cardA: UIImageView!
    @IBOutlet weak var cardB: UIImageView!
    @IBOutlet weak var cardC: UIImageView!
    @IBOutlet weak var cardD: UIImageView!
    @IBOutlet weak var cardE: UIImageView!
    @IBOutlet weak var cardF: UIImageView!
    @IBOutlet weak var cardG: UIImageView!
    @IBOutlet weak var cardH: UIImageView!
    @IBOutlet weak var cardI: UIImageView!
    @IBOutlet weak var cardJ: UIImageView!
    @IBOutlet weak var cardK: UIImageView!
    @IBOutlet weak var cardL: UIImageView!
    @IBOutlet weak var cardM: UIImageView!
    @IBOutlet weak var cardNorth: UIImageView!
    @IBOutlet weak var cardSouth: UIImageView!
    @IBOutlet weak var cardEast: UIImageView!
    @IBOutlet weak var cardWest: UIImageView!
    
    var currentRule: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(currentRule!) / \(playingRules.count)"
            ruleLbl.text = playingRules[currentRule - 1]
        }
    }
    var trumpSuit: Suit? {
        didSet {
            if (trumpSuit != nil) {
                trumpSuitImg.image = UIImage(named: trumpSuit!.rawValue)
            } else {
                trumpSuitImg.image = UIImage(named: "NA")
            }
        }
    }
    var selectedSuit: Suit? {
        didSet {
            if (selectedSuit != nil) {
                selectedSuitImg.image = UIImage(named: trumpSuit!.rawValue)
            } else {
                selectedSuitImg.image = UIImage(named: "NA")
            }
        }
    }
    var playerHand: [Card]? {
        didSet {
            if ((playerHand?.count)! > 0 && (playerHand?.count)! <= 13) {
                for (index, card) in playerHand!.enumerated() {
                    cardImages[index].image = UIImage(named: "Card\(card.Suit.rawValue)\(card.Rank.rawValue)")
                }
            }
        }
    }
    var cardImages: [UIImageView]!

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        populateCardImages()
        currentRule = 1
        displayLesson()
    }
    
    func displayLesson() {
        cleanup()
        switch currentRule {
        case 1:
            for cardNumber in 0..<13 {
                let currentCard = cardImages[cardNumber]
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: currentCard.frame.width, height: currentCard.frame.width))
                label.center = CGPoint(x: currentCard.superview!.frame.origin.x + currentCard.frame.midX, y: currentCard.superview!.frame.origin.y + currentCard.frame.midY)
                label.textAlignment = .center
                label.text = "\(cardNumber + 1)"
                label.textColor = UIColor.red
                label.font = UIFont(name: "AvenirNext-Heavy", size: 40)
                label.tag = 322
                self.view.addSubview(label)
            }
        case 2:
            if var deck = Deck() {
                let hands = deck.deal(players: 4)
                playerHand = hands[0]
            }
            
        case 3:
            return
        case 4:
            return
        case 5:
            return
        default:
            print("something wrong occured; displaying rule \(currentRule) of 5.")
        }
        
        // rule 1: display 1-13 on cards (no trump, no selected)
        // rule 2: let player play (no trump, selected)
        // rule 3: let player trump (trump, selected)
        // rule 4: let player trump (trump, selected)
        // rule 5: play (trump, selected)
    }
    
    func cleanup() {
        for v in view.subviews {
            if v.tag == 322 {
                v.removeFromSuperview()
            }
        }
    }
    
    func populateCardImages() {
        cardImages = [UIImageView]()
        cardImages.append(cardA)
        cardImages.append(cardB)
        cardImages.append(cardC)
        cardImages.append(cardD)
        cardImages.append(cardE)
        cardImages.append(cardF)
        cardImages.append(cardG)
        cardImages.append(cardH)
        cardImages.append(cardI)
        cardImages.append(cardJ)
        cardImages.append(cardK)
        cardImages.append(cardL)
        cardImages.append(cardM)
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        if currentRule == playingRules.count {
            currentRule = 1
        } else {
            currentRule = currentRule! + 1
        }
        displayLesson()
    }
}
