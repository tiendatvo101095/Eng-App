//
//  UsersViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/8/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UsersViewController: UIViewController {
    
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var createNewGameBtn: UIButton!
    @IBOutlet weak var usernameView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewBg.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        
        usernameView.borderStyle = .none
        usernameView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
//        usernameView.placeholder = "Username"
        usernameView.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordView.borderStyle = .none
        passwordView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
