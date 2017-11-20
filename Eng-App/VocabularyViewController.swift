//
//  VocabularyViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/15/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class VocabularyViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VRObjectCollectionViewCell
        return cell
    }
    
    @IBOutlet var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // debug scene to see feature points and world's origin
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    //get position
    
    
    //TEST DETECT PLAN
    func loadModel(hitPosition : SCNVector3) {
        guard let virtualObjectScene = SCNScene(named: "RockPigeon.scn", inDirectory: "Models.scnassets/RockPigeon") else {return }
        
        let wrapperNode = SCNNode()
        
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            child.movabilityHint = .movable
            wrapperNode.position = hitPosition
            wrapperNode.addChildNode(child)
        }
        sceneView.scene.rootNode.addChildNode(wrapperNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let results = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitFeature = results.last else { return }
        let hitTransform = SCNMatrix4(hitFeature.worldTransform)
        // <- if higher than beta 1, use just this -> hitFeature.worldTransform
        let hitPosition = SCNVector3Make(hitTransform.m41,
                                         hitTransform.m42,
                                         hitTransform.m43)
        
        loadModel(hitPosition: hitPosition)
    }
    
}
