//
//  ArchimentViewController.swift
//  Eng-App
//
//  Created by Nguyen Hoai on 11/21/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit

class ArchimentViewController: UIViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var contentBg: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBg.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        contentBg.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        contentBg.layer.cornerRadius = 10
        
        currentLevel.backgroundColor = UIColor(patternImage: UIImage(named: "level-bg")!)
        
        backButton.layer.cornerRadius = 25
        backButton.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
