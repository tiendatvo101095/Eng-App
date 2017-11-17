//
//  DetectPlane.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/17/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import Foundation
import ARKit

class DetectPlane: SCNNode {
    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ARKit
    
    func update(_ anchor: ARPlaneAnchor) {
        self.anchor = anchor
    }
}


