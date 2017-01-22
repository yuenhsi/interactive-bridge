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
        performSegue(withIdentifier: "PlayingVC", sender: nil)
    }
    
    @IBAction func btnTwoPressed(_ sender: Any) {
        performSegue(withIdentifier: "PlayingVC", sender: nil)
    }
    
    @IBAction func btnThreePressed(_ sender: Any) {
        performSegue(withIdentifier: "PlayingVC", sender: nil)
    }
    
}
