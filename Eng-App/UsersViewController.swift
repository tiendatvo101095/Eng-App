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
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
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
    
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
