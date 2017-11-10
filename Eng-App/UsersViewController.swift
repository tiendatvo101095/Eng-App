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
    
    // Sign up
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
   //..
    var selectedData: UsersModel?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedData = usersList[indexPath.row]
       // var key:String?
        let username = (selectedData?.name)! + "@gmail.com"
        let key = selectedData?.name
        print(username)
        Auth.auth().signIn(withEmail: username, password: key!, completion: { (user, error) in
            if (error == nil){
                print("Success")
                self.performSegue(withIdentifier: "toLogin", sender: nil)
            }
            
        })
       
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if (segue.identifier == "toLogin"){
//            let toWelcomeVC = segue.destination as! WelcomeViewController
//            toWelcomeVC.userPath = selectedData
//
//            Auth.auth().signIn(withEmail: (selectedData?.name)! + "@gmail.com", password: (selectedData?.name)!, completion: { (user, error) in
//                if error != nil {
//                    print("Success!!!")
//                }
//                else{
//                    print("Somethings wrong!!!")
//                }
//            })
//           // print(selectedData?.name)
//
//        }
//    }

}
