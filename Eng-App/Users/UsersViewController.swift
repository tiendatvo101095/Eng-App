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
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorText.isHidden = true
        errorText.layer.masksToBounds = true
//        errorText.layer.cornerRadius = 10
        
        viewBg.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        
        usernameView.backgroundColor = UIColor(white: 1, alpha: 0)
        usernameView.borderStyle = .none
        usernameView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        usernameView.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        passwordView.backgroundColor = UIColor(white: 1, alpha: 0)
        passwordView.borderStyle = .none
        passwordView.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        passwordView.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        loginButton.backgroundColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        loginButton.setTitleColor(UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0), for: .normal)
        loginButton.layer.cornerRadius = 20
        
        signupButton.setTitleColor(
            UIColor(red:0.99, green:0.76, blue:0.00, alpha:1.0), for: .normal)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func login() {
        let username = usernameView.text
        let password = passwordView.text
        if (username == "" || password == "") {
            self.errorText.text = "Please enter your username and password"
            self.errorText.isHidden = false
            return
        }
        let email = (username)! + "@gmail.com"
        Auth.auth().signIn(withEmail: email, password: password!) { (user, error) in
            if (error == nil) {
                print("dang nhap thanh cong")
                self.errorText.isHidden = true
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "welcomeViewController") as! WelcomeViewController
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                print("dang nhap that bai")
                self.errorText.text = "Wrong username or password"
                self.errorText.isHidden = false
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    @IBAction func loginButtonTap(_ sender: Any) {
        self.login()
    }
    
    @IBAction func enterTap(_ sender: Any) {
        self.login()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
