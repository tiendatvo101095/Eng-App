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



class UsersViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var usersList = [UsersModel]()
    var userRef:DatabaseReference!
    @IBOutlet weak var collectionViewUser: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRef = Database.database().reference()
        fetchUser()
        signOut()
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Log out from UsersViewController")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    // Fetch User from Firebase
    func fetchUser() {
        userRef.child("users").observe(.childAdded, with: { (snapshot) in
                    
            let value = snapshot.value as? NSDictionary
            let UserName = value!["name"]
            let users = UsersModel(name: UserName as? String)
            self.usersList.append(users)
            //}
            DispatchQueue.main.async{
                self.collectionViewUser.reloadData()
            }
        })
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UsersCollectionViewCell
        
        let users: UsersModel
        users = usersList[indexPath.row]
        cell.userNameLabel.text = users.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Sign up
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    //....
    
    var usersPathData: UsersModel?

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        usersPathData = usersList[indexPath.row]
            let email = (usersPathData?.name)! + "@gmail.com"
            let key = usersPathData?.name
            print(key?.description as Any)
            Auth.auth().signIn(withEmail: email, password: key!) { (user, error) in
                if (error == nil){
                    print("SUCCESS!!!")
                    
                     self.performSegue(withIdentifier: "toLogin", sender: indexPath)
                }else{
                    print("LOGIN FAILS")
                  
                }
            }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "toLogin"){
            guard let selectedIndexPath = sender as? NSIndexPath,
                let detailsVC = segue.destination as? WelcomeViewController else { return }
            print("*************************************")
            usersPathData = usersList[selectedIndexPath.row]
            detailsVC.userPath = usersPathData
        }
        
    }
    
    
}
