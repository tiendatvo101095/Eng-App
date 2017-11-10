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
    
    var userPath: UsersModel?
    var email:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //    userNameLabel.text = userPath?.name
        userNameLabel.text = email?.description
        // Do any additional setup after loading the view.
    }
    
    
    func login(){
        
        let email = (userPath?.name)! + "@gmail.com"
        let key = userPath?.name
        
        Auth.auth().signIn(withEmail: email, password: key!) { (user, error) in
            if (error != nil){
                print("SUCCESS!!!")
            }
        }
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
