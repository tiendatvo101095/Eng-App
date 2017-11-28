//
//  ResultViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/20/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResultViewController: UIViewController {
    
    @IBOutlet weak var mainBackground: UIView!
    @IBOutlet weak var subBackground: UIView!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var result:String = "You got 8 points"

    override func viewDidLoad() {
        super.viewDidLoad()
        mainBackground.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        subBackground.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 25
        backButton.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
        
        resultText.text = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
