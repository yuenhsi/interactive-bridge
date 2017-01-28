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
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var nextImg: UIImageView!
    
    var currentRule: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(currentRule!) / \(playingRules.count)"
            ruleLbl.text = playingRules[currentRule - 1]
        }
    }
    var selectedSuit: Suit? {
        didSet {
            if (selectedSuit != nil) {
                selectedSuitImg.image = UIImage(named: selectedSuit!.rawValue)
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
    var hands: [Hand]! {
        didSet {
            // by convention, playerHand is always the first item, followed by West, North, then East; player is always South.
            if hands.count > 0  {
                playerHand = hands[0]
            }
        }
    }
    var playerHand: Hand! {
        didSet {
            if (playerHand != nil) {
                playerHand!.sort()
            }
            playerCardsStk.refreshCards(playerHand!)
        }
    }
    var respondingToTouches = false
    var selectedCard: CardImageView?
    weak var timer: Timer?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOccurred)))
    
        currentRule = 1
        startLessons()
    }
    
    func flashNextImg(currentRule: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            if (self?.currentRule == 1) {
                self?.nextImg.image = UIImage(named: "NextFlipped")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    self?.nextImg.image = UIImage(named: "Next")
                }
            } else {
                self?.timer?.invalidate()
            }
        }
    }
    
    func startLessons() {
        switch currentRule {
        case 1:
            for (index, v) in playerCardsStk.subviews.enumerated() {
                if let card = v as? CardImageView {
                    card.setLabel(labelText: "\(index + 1)")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
                self.flashNextImg(currentRule: 1)
            }
            
        case 2:
            var deck = Deck()!
            deck.shuffle()
            // ensure each player has 2 of each suit
            var hands = deck.deal(special: handReqs.TWO_EACH_SUIT)
            // by convention, playerHand is always the first item, followed by West, North, then East; player is always South.
            playerHand = hands[0]
            let playedRound = playRound(lead: .west, hands: &hands)
            animatePlayCards(round: playedRound, lead: .west)
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
    
    func startGame(special: handReqs?, lead: Position) {
        var deck = Deck()!
        deck.shuffle()
        hands = deck.deal(special: special)
        
        let playedRound = playRound(lead: lead, hands: &hands)
        animatePlayCards(round: playedRound, lead: .west)
    }
    
    func tapOccurred(sender: UIGestureRecognizer) {
        if (respondingToTouches) {
            let location = sender.location(in: playerCardsStk)
            let touchedView = playerCardsStk.hitTest(location, with: nil)
            if let tappedCard = touchedView as? CardImageView {
                if (selectedCard == nil) {
                    selectedCard = tappedCard
                    UIView.animate(withDuration: 0.2, animations: {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                    })
                } else {
                    if selectedCard!.card == tappedCard.card! {
                        playSelectedCard()
                        selectedCard = nil
                    } else {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
                        selectedCard = tappedCard
                        UIView.animate(withDuration: 0.2, animations: {
                            self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                        })
                    }
                }
            }
        }
        
    }
    
    func playSelectedCard() {
        if (selectedCard?.card!.Suit != selectedSuit) {
            selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
            selectedCard = nil
            
            warningLbl.text = "Please follow suit!"
            warningLbl.alpha = 1
            
            UIView.animate(withDuration: 1, animations: {
                self.warningLbl.alpha = 0
            })
        } else {
            cardSouth.image = UIImage(named: getCardImageName(selectedCard!.card!))
            playerCardsStk.removeCard(card: selectedCard!.card!)
            selectedCard = nil
            respondingToTouches = false
        }
    }
    
    func animatePlayCards(round: [Card], lead: Position) {
        if (lead == .south) {
            return
        }
        selectedSuit = round[0].Suit
        var roundOver = false
        var currentTurn = lead
        var currentIndex = 0
        while !roundOver {
            switch(currentTurn) {
            case .west:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(currentIndex * 500)) { [currentIndex] in
                    self.cardWest.image = UIImage(named: getCardImageName(round[currentIndex]))
                    self.cardWest.layer.zPosition = 1
                }
                currentIndex += 1
                currentTurn = .north
            case .north:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(currentIndex * 500)) { [currentIndex] in
                    self.cardNorth.image = UIImage(named: getCardImageName(round[currentIndex]))
                    self.cardNorth.layer.zPosition = 2
                }
                currentIndex += 1
                currentTurn = .east
            case .east:
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(currentIndex * 500)) { [currentIndex] in
                    self.cardEast.image = UIImage(named: getCardImageName(round[currentIndex]))
                    self.cardEast.layer.zPosition = 3
                    self.respondingToTouches = true
                }
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
        startLessons()
    }
    
    @IBAction func prevBtnPressed(_ sender: Any) {
        if currentRule == 1 {
            currentRule = playingRules.count
        } else {
            currentRule = currentRule! - 1
        }
        startLessons()
    }
}
