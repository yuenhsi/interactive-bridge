//
//  TutorialVC.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/22/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController {
    
    var type: Tutorial!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        switch type! {
        case .bidding:
            return
        case .playing:
            return
        case .scoring:
            return
        }
    }

}
