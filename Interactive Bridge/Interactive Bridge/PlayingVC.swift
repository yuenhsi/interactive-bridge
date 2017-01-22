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
    @IBOutlet weak var trumpSuitLbl: UILabel!
    @IBOutlet weak var selectedSuitImg: UIImageView!
    
    let ruleCount = 5
    var ruleNumber: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(ruleNumber!) / \(ruleCount)"
            ruleLbl.text = playingRules[ruleNumber - 1]
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        displayLesson(rule: 1)
    }
    
    func displayLesson(rule: Int) {
        ruleNumber = rule
        
        // rule 1: display 1-13 on cards (no trump, no selected)
        // rule 2: let player play (no trump, selected)
        // rule 3: let player trump (trump, selected)
        // rule 4: let player trump (trump, selected)
        // rule 5: play (trump, selected)
    }

}
