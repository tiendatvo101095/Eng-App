//
//  ScoreboardViewCell.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/29/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit

class ScoreboardViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderNumber.textColor = UIColor(red:0.73, green:0.73, blue:0.73, alpha:1.0)
        score.textColor = UIColor(red:0.15, green:0.72, blue:0.00, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
