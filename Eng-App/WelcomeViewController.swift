//
//  WelcomeViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/8/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class WelcomeViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var topBg: UIView!
    @IBOutlet weak var bottomBg: UIView!
    @IBOutlet weak var archievementBtn: UIButton!
    
    
    var userPath: UsersModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cur = Auth.auth().currentUser
        let name = cur?.email
        let endIndex = name?.index((name?.endIndex)!, offsetBy: -10)
        let truncated = name?.substring(to: endIndex!)
        userNameLabel.text = truncated?.description
        
        topBg.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        bottomBg.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        archievementBtn.layer.cornerRadius = 10
        archievementBtn.layer.borderWidth = 1
        archievementBtn.layer.borderColor = UIColor.white.cgColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Log out button
    @IBAction func LogoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Log out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    //....


}
