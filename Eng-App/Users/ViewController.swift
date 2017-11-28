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
    @IBOutlet weak var errorTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorTextView.isHidden = true
        
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
    
    func signup() {
        let userName = usernameView.text!
        let email = userName + "@gmail.com"
        let password = passwordView.text
        let confirmPass = confirmPasswordView.text
        if (email == "" || password == "") {
            errorTextView.text = "Please fill full information"
            errorTextView.isHidden = false
            return
        }
        if (password != confirmPass) {
            errorTextView.text = "Cofirm password is not correct"
            errorTextView.isHidden = false
            return
        }
        Auth.auth().createUser(withEmail: email, password: password!) { (user, error) in
            if (error == nil) {
                Auth.auth().signIn(withEmail: email, password: password!) { (user, error) in
                    if (error == nil) {
                        print("dang nhap thanh cong")
                        self.errorTextView.isHidden = true
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "welcomeViewController") as! WelcomeViewController
                        self.present(nextViewController, animated:true, completion:nil)
                        //.. Add data to Firebase Datanbase
                        var ref: DatabaseReference!
                        ref = Database.database().reference(fromURL: "https://fir-43245.firebaseio.com/")
                        guard let uid = user?.uid else{return}
                        
                        let userRef = ref.child("users").child(uid)
                        let value = ["name": userName, "score": ""]
                        userRef.updateChildValues(value, withCompletionBlock: { (err, ref) in
                            
                            if let err = err {
                                print(err)
                                return
                            }
                            print("Saved user successfully into Firebase db")
                        })
                    } else {
                        print("dang nhap that bai")
                        self.errorTextView.text = "Please chose another username"
                        self.errorTextView.isHidden = false
                    }
                }
            } else {
                
            }
        }
    }

    @IBAction func signupButtonTap(_ sender: Any) {
        signup()
    }
    
    @IBAction func enterTap(_ sender: Any) {
        signup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

