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
    @IBOutlet weak var playerOneStk: CardsStackView!
    @IBOutlet weak var playerTwoStk: CardsStackView!
    @IBOutlet weak var playerThreeStk: CardsStackView!
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var nextImg: UIImageView!
    @IBOutlet weak var tricksLbl: UILabel!
    
    var playerTricks = 0 {
        didSet {
            tricksLbl.text = "Tricks: \(playerTricks) - \(opponentTricks)"
        }
    }
    var opponentTricks = 0 {
        didSet {
            tricksLbl.text = "Tricks: \(playerTricks) - \(opponentTricks)"
        }
    }
    var currentRule: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(currentRule!) / \(playingRules.count)"
            ruleLbl.text = playingRules[currentRule - 1]
            giveLesson()
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
    }
    
    
    func giveLesson() {
        
        switch currentRule {
        case 1:
            
            // rule 1: display 1-13 on cards (no trump, no selected)
            for (index, v) in playerCardsStk.subviews.enumerated() {
                if let card = v as? CardImageView {
                    card.setLabel(labelText: "\(index + 1)")
                }
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
                self.flashNextImg(currentRule: 1)
            }
        
        case 2:
            
            // rule 2: let player play (no trump, selected)
            cardThreshold = 11
            startGame(special: .TWO_EACH_SUIT, lead: .west)
        
        case 3:
            
            // rule 3: win, then lead (no trump, selected)
            cardThreshold = 11
            startGame(special: .ACE_EACH_SUIT, lead: .west)
        
        case 4:
            
            // rule 4: trump, then lead (trump, selected)
            cardThreshold = 11
            trumpSuit = randomSuit()
            startGame(special: .TWO_EACH_SUIT, lead: .west)
            return
        
        case 5:
            
            trumpSuit = randomSuit()
            startGame(special: nil, lead: .west)
            // rule 5: play (trump, selected)
            return
            
        default:
            print("something wrong occured; displaying rule \(currentRule) of 5.")
        }
    }
    
    
    func startGame(special: handReqs?, lead: Position) {
        
        var deck = Deck()!
        hands = deck.deal(special: special)
        updatePlayerCards()
        
        round = playRound(lead: lead, hands: hands)
        playCards(round: round)
    }
    
    
    func playCards(round: [(position: Int, card: Card)], afterRoundEnds: @escaping (() -> ()) = {}) {
        
        if round.count == 0 {
            
            // player is starting the round, thus playRound returned and empty array
            selectedSuit = nil
            self.respondingToTouches = true
            
        } else {
            
            // check whether player has played yet this round
            selectedSuit = round[0].card.Suit
            let startingIndex = round.index(where: { $0.position == 4 }) ?? -1
            
            for (index, play) in round.enumerated() {
                
                // if player has played this round, cards played prior to player's card have already been displayed
                if index > startingIndex {
                    
                    let slot = getSlot(position: play.position)
                    let stack = getStack(position: play.position)
                    
                    hands[play.position].removeCard(card: play.card)
                    stack.removeCard()
                    
                    var delay: Int
                    var zIndex: Int
                    
                    if startingIndex != -1 {
                        delay = (index - startingIndex) * 500
                        zIndex = index + 4
                    } else {
                        delay = index * 500
                        zIndex = index + 1
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(delay)) { [zIndex, index, stack] in
                        
                        slot.image = UIImage(named: getCardImageName(play.card))
                        slot.layer.zPosition = CGFloat(zIndex)
                        stack.removeCard()
                        
                        if slot == self.cardThree {
                            // enable touch if it's player's turn
                            self.respondingToTouches = true
                        }
                        if index == 3 {
                            // execute afterRoundEnds closure if round has ended
                            afterRoundEnds()
                        }
                    }
                }
            }
        }
    }
    
    
    func tapOccurred(sender: UIGestureRecognizer) {
        
        if (respondingToTouches) {
            
            let location = sender.location(in: playerCardsStk)
            let touchedView = playerCardsStk.hitTest(location, with: nil)
            
            if let tappedCard = touchedView as? CardImageView {
                
                // no cards already selected
                if (selectedCard == nil) {
                    
                    selectedCard = tappedCard
                    UIView.animate(withDuration: 0.2, animations: {
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                    })
                    
                } else {
                    
                    // selected card differs from tapped card
                    if selectedCard!.card != tappedCard.card! {
                        
                        self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: 0)
                        selectedCard = tappedCard
                        UIView.animate(withDuration: 0.2, animations: {
                            self.selectedCard!.transform = CGAffineTransform(translationX: 0, y: -20)
                        })
                        
                    } else {
                        
                        // selected card tapped; doesn't correspond to selectedSuit; player has selectedSuit
                        if (selectedCard!.card!.Suit != selectedSuit && playerHand.hasSuit(suit: selectedSuit)) {
                            
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
                            
                            if round.count != 4 {
                                
                                round = finishRound(round: round, hands: hands)
                                playCards(round: round, afterRoundEnds: {
                                    let winner = getRoundWinner(round: self.round, trump: self.trumpSuit)
                                    if (winner % 2 == 0) {
                                        self.playerTricks += 1
                                    } else {
                                        self.opponentTricks += 1
                                    }
                                    self.round = nil
                                    self.showWinnerAndContinue(winner: winner)
                                })
                                
                            } else {
                                let winner = getRoundWinner(round: round, trump: trumpSuit)
                                if (winner % 2 == 0) {
                                    playerTricks += 1
                                } else {
                                    opponentTricks += 1
                                }
                                round = nil
                                showWinnerAndContinue(winner: winner)
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
        updatePlayerCards()
    }
    
    func showWinnerAndContinue(winner: Int) {
        let winnerCard = getSlot(position: winner)
        winnerCard.layer.borderColor = UIColor.red.cgColor
        winnerCard.layer.borderWidth = 2
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) { [winnerCard, winner] in
            winnerCard.layer.borderWidth = 0
            self.cardOne.image = nil
            self.cardTwo.image = nil
            self.cardThree.image = nil
            self.cardFour.image = nil
            
            self.continueGame(roundWinner: winner)
        }
    }
    
    func continueGame(roundWinner: Int) {
        if cardThreshold != nil {
            if playerHand.cards.count < cardThreshold! {
                flashNextImg(currentRule: currentRule)
            }
        }
        if playerHand.cards.count > 0 {
            round = playRound(lead: getPositionFromNumber(number: roundWinner, playerPosition: .south), hands: hands)
            playCards(round: round)
        }
    }
    
    func getSlot(position: Int) -> UIImageView {
        if position == 1 {
            return self.cardOne
        }
        if position == 2 {
            return self.cardTwo
        }
        if position == 3 {
            return self.cardThree
        }
        if position == 4 {
            return self.cardFour
        }
        print("position not between range of 1 to 4")
        return UIImageView()
    }
    
    func getStack(position: Int) -> CardsStackView {
        if position == 1 {
            return self.playerOneStk
        }
        if position == 2 {
            return self.playerTwoStk
        }
        if position == 3 {
            return self.playerThreeStk
        }
        if position == 4 {
            return self.playerCardsStk
        }
        print("position not between range of 1 to 4")
        return CardsStackView()
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
    }
    
    @IBAction func prevBtnPressed(_ sender: Any) {
        if currentRule == 1 {
            currentRule = playingRules.count
        } else {
            currentRule = currentRule! - 1
        }
    }
}
