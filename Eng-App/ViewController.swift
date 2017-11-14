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
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var gameNowBg: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(viewBg.frame.size)
        UIImage(named: "app-bg.jpg")?.draw(in: viewBg.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        viewBg.backgroundColor = UIColor(patternImage: image)
        
        gameNowBg.backgroundColor = UIColor(red:0.12, green:0.60, blue:1.00, alpha:1.0)
        gameNowBg.layer.cornerRadius = 30
        
        userNameTextField.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        userNameTextField.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    @IBAction func StartButton(_ sender: Any) {
        let email = userNameTextField.text!
        Auth.auth().createUser(withEmail: email + "@gmail.com", password: email, completion: {(user:User?, error) in

                var ref: DatabaseReference!
                ref = Database.database().reference(fromURL: "https://fir-43245.firebaseio.com/")
                guard let uid = user?.uid else{return}
                
                let userRef = ref.child("users").child(uid)
                let value = ["name": email]

                userRef.updateChildValues(value, withCompletionBlock: { (err, ref) in
                    
                    if let err = err {
                        print(err)
                        return
                    }
                    
                    print("Saved user successfully into Firebase db")
                    
                })
        })
        
 
    }
    
    
}

