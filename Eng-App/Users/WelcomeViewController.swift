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
    
    @IBOutlet weak var Vocabulary: UIButton!
    @IBOutlet weak var youWantToLearTitle: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
    
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
        
        archievementBtn.layer.cornerRadius = 20
        archievementBtn.layer.borderWidth = 1
        archievementBtn.layer.borderColor = UIColor.white.cgColor
        
        youWantToLearTitle.textColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)
        
        logOutBtn.backgroundColor = UIColor(red:0.95, green:0.30, blue:0.30, alpha:1.0)
        logOutBtn.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
        logOutBtn.layer.cornerRadius = 5
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
