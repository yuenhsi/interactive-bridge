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
    @IBOutlet weak var cardNorth: UIImageView!
    @IBOutlet weak var cardSouth: UIImageView!
    @IBOutlet weak var cardEast: UIImageView!
    @IBOutlet weak var cardWest: UIImageView!
    @IBOutlet weak var playerCardsStk: CardsStackView!
    
    var currentRule: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(currentRule!) / \(playingRules.count)"
            ruleLbl.text = playingRules[currentRule - 1]
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
    var trumpSuit: Suit? {
        didSet {
            if (trumpSuit != nil) {
                trumpSuitImg.image = UIImage(named: trumpSuit!.rawValue)
            } else {
                trumpSuitImg.image = UIImage(named: "NA")
            }
        }
    }
    var playerHand: [Card]? {
        didSet {
            if (playerHand != nil) {
                playerHand!.sort { sortCardsBySuit(first: $0, second: $1) }
            }
            playerCardsStk.refreshCards(playerHand!)
        }
    }
    var respondingToTouches = false
    var selectedCard: CardImageView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOccurred))
        view.addGestureRecognizer(tap)
    
        currentRule = 1
        displayLesson()
    }
    
    func displayLesson() {
        switch currentRule {
        case 1:
            for v in playerCardsStk.subviews {
                if let card = v as? CardImageView {
                    card.setLabel(labelText: "\(card.tag)")
                }
            }
            
        case 2:
            var deck = Deck()!
            deck.shuffle()
            var hands = deck.deal(players: 4)
            // by convention, playerHand is always the first item, followed by West, North, then East; player is always South.
            playerHand = hands[0]
            let playedRound = playRound(lead: .west, hands: &hands)
            animatePlayCards(round: playedRound, lead: .west)
            respondingToTouches = true
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
    
    func tapOccurred(sender: UIGestureRecognizer) {
        if (respondingToTouches) {
            let location = sender.location(in: playerCardsStk)
            let touchedView = playerCardsStk.hitTest(location, with: nil)
            if let tappedCard = touchedView as? CardImageView {
                if (selectedCard == nil) {
                    selectedCard = tappedCard
                    UIView.animate(withDuration: 0.3, animations: {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                    })
                } else {
                    if selectedCard!.card == tappedCard.card! {
//                        playSelectedCard()
                    } else {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
                        selectedCard = tappedCard
                        UIView.animate(withDuration: 0.3, animations: {
                            self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                        })
                    }
                }
            }
        }
        
    }
    
    func animatePlayCards(round: [Card], lead: Position) {
        if (lead == .south) {
            return
        }
        var roundOver = false
        var currentTurn = lead
        var currentIndex = 0
        while !roundOver {
            switch(currentTurn) {
            case .west:
                cardWest.image = UIImage(named: getCardImageName(round[currentIndex]))
                cardWest.layer.zPosition = 1
                currentIndex += 1
                currentTurn = .north
            case .north:
                cardNorth.image = UIImage(named: getCardImageName(round[currentIndex]))
                cardNorth.layer.zPosition = 2
                currentIndex += 1
                currentTurn = .east
            case .east:
                cardEast.image = UIImage(named: getCardImageName(round[currentIndex]))
                cardEast.layer.zPosition = 3
                currentIndex += 1
                roundOver = true
            case .south:
                print("something went wrong.")
                return
            }
        }
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
