//
//  ArchimentViewController.swift
//  Eng-App
//
//  Created by Nguyen Hoai on 11/21/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class ArchimentViewController: UIViewController {

    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var contentBg: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var currentLevel: UILabel!
    @IBOutlet weak var progressBarView: UIProgressView!
    
    var curr = Auth.auth().currentUser
    var ref: DatabaseReference!
    var usersList = [UsersModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        userScore()
        viewBg.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        contentBg.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        contentBg.layer.cornerRadius = 10
        
        currentLevel.backgroundColor = UIColor(patternImage: UIImage(named: "level-bg")!)
        
        backButton.layer.cornerRadius = 25
        backButton.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
        
//        self.progressBarView.bounds.size.height = 10
        progressBarView.transform = CGAffineTransform(scaleX: 1, y: 10)
        progressBarView.clipsToBounds = true
        progressBarView.layer.cornerRadius = 15
        progressBarView.trackTintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        progressBarView.progressTintColor = UIColor(red:0.97, green:0.67, blue:0.13, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userScore(){
        if curr == nil {
            //..go to login
        }else{
            guard let uid = curr?.uid else{return}
            print(uid)
            ref = Database.database().reference()
            ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let value = snapshot.value as? NSDictionary
                let UserName = value!["name"]
                let userScore = value!["score"]
                let users = UsersModel(name: UserName as? String, score: userScore as? Int)
                
                self.currentLevel.text = users.score?.description
                
                UIView.animate(withDuration: 2, animations: {() -> Void in
                    self.progressBarView.setProgress(Float(users.score!) / 8, animated: true)
                })
            }){ (error) in
                print("ERROR!!!")
                print(error.localizedDescription)
            }
        }
        
    }
}
