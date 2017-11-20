//
//  ResultViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/20/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var resultText: UILabel!
    var result:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultText.text = result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
