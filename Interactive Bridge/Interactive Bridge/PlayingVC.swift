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
    @IBOutlet weak var trumpSuitLbl: UILabel!
    @IBOutlet weak var selectedSuitImg: UIImageView!
    
    let ruleCount = 5
    var ruleNumber: Int! {
        didSet {
            titleLbl.text = "Playing: Rule \(ruleNumber!) / \(ruleCount)"
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        ruleNumber = 1
    }
    
    func displayLesson() {
        
    }

}
