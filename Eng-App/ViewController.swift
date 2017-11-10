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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

