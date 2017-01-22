//
//  SelectionVC.swift
//  Interactive Bridge
//
//  Created by Yuen Hsi Chang on 1/20/17.
//  Copyright © 2017 Yuen Hsi Chang. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnOnePressed(_ sender: Any) {
        performSegue(withIdentifier: "TutorialVC", sender: Tutorial.playing)
    }
    
    @IBAction func btnTwoPressed(_ sender: Any) {
        performSegue(withIdentifier: "TutorialVC", sender: Tutorial.bidding)
    }
    
    @IBAction func btnThreePressed(_ sender: Any) {
        performSegue(withIdentifier: "TutorialVC", sender: Tutorial.scoring)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TutorialVC" {
            if let segueVC = segue.destination as? TutorialVC {
                if let tutorialType = sender as? Tutorial {
                    segueVC.type = tutorialType
                }
            }
        }
    }
    
}
