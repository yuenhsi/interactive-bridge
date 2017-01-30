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
    @IBOutlet weak var cardOne: UIImageView!
    @IBOutlet weak var cardTwo: UIImageView!
    @IBOutlet weak var cardThree: UIImageView!
    @IBOutlet weak var cardFour: UIImageView!
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
    var hands: [Hand]!
    var playerHand: Hand! {
        get {
            return hands[0]
        }
    }
    var round: [(position: Int, card: Card)]!
    var respondingToTouches = false
    var cardThreshold: Int?
    var selectedCard: CardImageView?
    weak var timer: Timer?

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOccurred)))
    
        currentRule = 1
        startLessons()
    }
    
    
    func startGame(special: handReqs?, lead: Position) {
        var deck = Deck()!
        hands = deck.deal(special: special)
        updatePlayerCards()
        
        round = playRound(lead: lead, hands: hands)
        playCards(round: round)
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
            cardThreshold = 11
            startGame(special: .TWO_EACH_SUIT, lead: .west)
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
    
    
    func playCards(round: [(position: Int, card: Card)]) {
        if round.count >= 1 {
            selectedSuit = round[0].card.Suit
        }
        for (index, play) in round.enumerated() {
            var cardImageView: UIImageView!
            switch play.position {
            case 1:
                cardImageView = self.cardOne
            case 2:
                cardImageView = self.cardTwo
            case 3:
                cardImageView = self.cardThree
            case 4:
                cardImageView = self.cardFour
            default:
                print("Error: default case reached in playCards")
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(index * 500)) { [index] in
                cardImageView.image = UIImage(named: getCardImageName(play.card))
                cardImageView.layer.zPosition = CGFloat(index + 1)
                if cardImageView == self.cardThree {
                    self.respondingToTouches = true
                }
            }
        }
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
                    if selectedCard!.card != tappedCard.card! {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
                        selectedCard = tappedCard
                        UIView.animate(withDuration: 0.2, animations: {
                            self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                        })
                    } else {
                        if (selectedCard?.card!.Suit != selectedSuit) {
                            selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
                            selectedCard = nil
                            warningLbl.text = "Please follow suit!"
                            warningLbl.alpha = 1
                            
                            UIView.animate(withDuration: 1, animations: {
                                self.warningLbl.alpha = 0
                            })
                        } else {
                            playCard(card: selectedCard!.card!)
                            selectedCard = nil
                            respondingToTouches = false
                            updatePlayerCards()
                            if round.count != 4 {
                                round = finishRound(round: round, hands: hands)
                            }
                            let winner = getRoundWinner(round: round, trump: trumpSuit)
                            showWinner(winner: winner)
                            
                            if cardThreshold != nil {
                                if playerHand.cards.count < cardThreshold! {
                                    flashNextImg(currentRule: currentRule)
                                } else {
                                    round = playRound(lead: getPositionFromNumber(number: winner, playerPosition: .west), hands: hands)
                                    playCards(round: round)
                                }
                            } else {
                                if playerHand.cards.count > 0 {
                                    round = playRound(lead: getPositionFromNumber(number: winner, playerPosition: .west), hands: hands)
                                    playCards(round: round)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func playCard(card: Card) {
        cardFour.image = UIImage(named: getCardImageName(card))
        cardFour.layer.zPosition = 4
        
        playerHand.removeCard(card: card)
        round.append((position: 4, card: card))
    }
    
    func showWinner(winner: Int) {
        // implement an animation of some sort to indicate winner
        
        cardOne.image = nil
        cardTwo.image = nil
        cardThree.image = nil
        cardFour.image = nil
    }
    
    func updatePlayerCards() {
        hands[0].sort()
        playerCardsStk.refreshCards(hands[0])
    }
    
    
    func flashNextImg(currentRule: Int) {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            if (self?.currentRule == currentRule) {
                self?.nextImg.image = UIImage(named: "NextFlipped")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    self?.nextImg.image = UIImage(named: "Next")
                }
            } else {
                self?.timer?.invalidate()
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
