//
//  Animals.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/20/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit

struct Animals: Decodable {
    let modelName: String
    let displayName: String
    let img: String
    
    init(modelName: String, displayName: String, img: String) {
        self.modelName = modelName
        self.displayName = displayName
        self.img = img
    }
}

