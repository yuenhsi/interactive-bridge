//
//  TutorialVC.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/22/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var trumpSuitLbl: UILabel!
    @IBOutlet weak var selectedSuitImg: UIImageView!
    
    var type: Tutorial!
    var ruleCount: Int!
    var ruleNumber: Int! {
        didSet {
            titleLbl.text = "\(type!.rawValue.capitalized): Rule \(ruleNumber!) / \(ruleCount!)"
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        switch type! {
        case .playing:
            ruleCount = 5
            ruleNumber = 2
            return
        case .bidding:
            ruleCount = 5
            ruleNumber = 2
            return
        case .scoring:
            ruleCount = 5
            ruleNumber = 2
            return
        }
    }
    
    func displayLesson() {
        
    }

}
