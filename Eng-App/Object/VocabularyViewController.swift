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
    var animals = [Animals]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! VRObjectCollectionViewCell
        let item = animals[indexPath.row]
        cell.imgObject.image = UIImage(named:"\(item.img)")
        return cell
        
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var sceneView: ARSCNView!
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var animalsName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONFile()
        // Do any additional setup after loading the view.
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = false
        
        // debug scene to see feature points and world's origin
        //self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        animalsName.text = ""
        animalsName.font = UIFont(name: "angella", size: 35 )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        removeObject()
        objectName = ""
    }
    
    //get position
    
    
    //TEST DETECT PLAN
    func loadModel(hitPosition : SCNVector3) {
        if(objectName == nil){
            objectName = "Fish"
        }else{
            guard let virtualObjectScene = SCNScene(named: objectName+".scn", inDirectory: "Models.scnassets/"+objectName) else {return }
        
            let wrapperNode = SCNNode()
        
            for child in virtualObjectScene.rootNode.childNodes {
                child.geometry?.firstMaterial?.lightingModel = .physicallyBased
                child.movabilityHint = .movable
                wrapperNode.position = hitPosition
                wrapperNode.addChildNode(child)
            }
            sceneView.scene.rootNode.addChildNode(wrapperNode)
            voiceSound()
            }
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
    var objectName: String!
    // Get Models from JSON File
    func getJSONFile(){
        guard let jsonURL = Bundle.main.url(forResource: "VirtualObjects", withExtension: "json") else {
            fatalError("Missing 'VirtualObjects.json' in bundle.")
        }
        do {
             let jsonData = try  Data(contentsOf: jsonURL)
            animals = try JSONDecoder().decode([Animals].self, from: jsonData)
            print(animals)
        } catch {
            fatalError("Unable to decode VirtualObjects JSON: \(error)")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        objectName = animals[indexPath.row].modelName
        animalsName.text = objectName.description
        print(objectName.description)
        removeObject()
        textSound()
    }
    
    func removeObject(){
        
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    //SOUND
    func textSound(){
        let url = Bundle.main.url(forResource: objectName+"Text", withExtension: ".mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("TEXT SOUND Error!!!")
        }
        audioPlayer.play()
    }
    //SOUND
    func voiceSound(){
        let url = Bundle.main.url(forResource: objectName, withExtension: ".mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("TEXT SOUND Error!!!")
        }
        audioPlayer.play()
    }
    @IBAction func backButton(_ sender: Any) {

    }
}
