//
//  ScoreboardViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/29/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import Firebase
class ScoreboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mainBg: UIView!
    @IBOutlet weak var backButton: UIButton!
    var scoreList = [UsersModel]()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchData()
        mainBg.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        
        backButton.layer.cornerRadius = 25
        backButton.backgroundColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
        backButton.setTitleColor(UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0), for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func fetchData() {
        ref.child("users").observe(.childAdded, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let userName = value!["name"]
            let score = value!["score"]
                    
            if(score != nil) {
                if(score as! Int > 0) {
                    let users = UsersModel(name: userName as? String, score: score as? Int)
                    self.scoreList.append(users)
                }
            }
            
            DispatchQueue.main.async{
                self.scoreList = self.scoreList.sorted(by: {$0.score! > $1.score!})
                self.tableView.reloadData()
            }
        })
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return scoreList.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ScoreboardViewCell
        let item = scoreList[indexPath.row]
//        let temp = scoreList.count
//        cell.orderNumber.text = temp.description
        cell.userAvatar.image = UIImage(named: "user-avatar")
        cell.username.text = item.name
        cell.score.text = item.score?.description
        return cell
    }

}
