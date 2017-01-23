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
    
    let ruleCount = 5
    var ruleNumber: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(ruleNumber!) / \(ruleCount)"
            ruleLbl.text = playingRules[ruleNumber - 1]
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

    override func viewDidLoad() {
        
        super.viewDidLoad()
        displayLesson(ruleNumber: 1)
    }
    
    func displayLesson(ruleNumber: Int) {
        
        switch ruleNumber {
        case 1:
            let label = UILabel(frame: CGRect(x: cardA.superview!.frame.origin.x + cardA.frame.origin.x, y: cardA.superview!.frame.origin.y + cardA.frame.origin.y, width: cardA.frame.width, height: cardA.frame.width))
            
            label.textAlignment = .center
            label.text = "1"
            self.view.addSubview(label)

        case 2:
            return
        case 3:
            return
        case 4:
            return
        case 5:
            return
        default:
            print("something wrong occured; displaying rule \(ruleNumber) of 5.")
        }
        
        // rule 1: display 1-13 on cards (no trump, no selected)
        // rule 2: let player play (no trump, selected)
        // rule 3: let player trump (trump, selected)
        // rule 4: let player trump (trump, selected)
        // rule 5: play (trump, selected)
    }

}
