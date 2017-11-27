//
//  ViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/8/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var confirmPasswordView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBg.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        
        usernameView.backgroundColor = UIColor(white: 1, alpha: 0)
        usernameView.borderStyle = .none
        usernameView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        usernameView.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordView.backgroundColor = UIColor(white: 1, alpha: 0)
        passwordView.borderStyle = .none
        passwordView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        passwordView.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        confirmPasswordView.backgroundColor = UIColor(white: 1, alpha: 0)
        confirmPasswordView.borderStyle = .none
        confirmPasswordView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        confirmPasswordView.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        signupButton.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        signupButton.setTitleColor(UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0), for: .normal)
        signupButton.layer.cornerRadius = 20
        
        loginButton.setTitleColor(
            UIColor(red:0.99, green:0.76, blue:0.00, alpha:1.0), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

