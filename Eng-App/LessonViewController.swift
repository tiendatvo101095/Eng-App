//
//  LessonViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/20/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class LessonViewController: UIViewController{
    @IBOutlet weak var answer: UILabel!
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    let configuration = ARWorldTrackingConfiguration()
    var checkAnswer:Bool!
    var playerPoint:Int = 0
    var animals = [Animals]()
    var animalNames = [Animals]()
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSONFile()
        
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        incorrectButton.isHidden = true
        correctButton.isHidden = true
        answer.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func compareAnswer(correctValue:Bool, playerValue:Bool) {
        if (correctValue == playerValue) {
            playerPoint = playerPoint + 1
            correctSound()
        } else {
            incorrectSound()
        }
        createObject()
    }
    
    func createObject() {
        removeObject()
        if (animals.count > 0) {
            let randomImage = Int(arc4random_uniform(UInt32(animals.count)))
            let myData = animals[randomImage].displayName
            CreateObject(name: myData)
//            animalVoice(name: myData)
            animals.remove(at: randomImage)
            
            let randomAnswer = Int(arc4random_uniform(UInt32(animalNames.count)))
            let myAnswer = animalNames[randomAnswer].displayName
            
            answer.text = myAnswer
            
            if (myData == myAnswer) {
                checkAnswer = true
            } else {
                checkAnswer = false
            }
        } else {
            print("Het hinh")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let secondViewController = storyBoard.instantiateViewController(withIdentifier: "resultView") as! ResultViewController
            
            secondViewController.result = "You got: " + String(playerPoint) + " point"
            self.present(secondViewController, animated:true, completion:nil)
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        createObject()
        incorrectButton.isHidden = false
        correctButton.isHidden = false
        startButton.isHidden = true
        answer.isHidden = false
    }
    
    @IBAction func correctButton(_ sender: Any) {
        let playerValue = true
        compareAnswer(correctValue: checkAnswer, playerValue: playerValue)
        //demo
    }
    
    @IBAction func inCorrectButton(_ sender: Any) {
        let playerValue = false
        compareAnswer(correctValue: checkAnswer, playerValue: playerValue)
    }
    
    // Get Models from JSON File
    func getJSONFile(){
        guard let jsonURL = Bundle.main.url(forResource: "VirtualObjects", withExtension: "json") else {
            fatalError("Missing 'VirtualObjects.json' in bundle.")
        }
        do {
            let jsonData = try  Data(contentsOf: jsonURL)
            animals = try JSONDecoder().decode([Animals].self, from: jsonData)
            animalNames = try JSONDecoder().decode([Animals].self, from: jsonData)
            
        } catch {
            fatalError("Unable to decode VirtualObjects JSON: \(error)")
        }
    }
    
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }
    
    func CreateObject(name:String){
        let objNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        objNode.position = SCNVector3(cc.x, cc.y-0.1, cc.z-0.5)
        
        guard let virtualObjectScene = SCNScene(named: name + ".scn", inDirectory: "Models.scnassets/" + name) else {
            return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        objNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(objNode)
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func removeObject(){
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    //SOUND
    func correctSound(){
        let url = Bundle.main.url(forResource: "correct", withExtension: ".mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("TEXT SOUND Error!!!")
        }
        audioPlayer.play()
    }
    //SOUND
    func incorrectSound(){
        
        let url = Bundle.main.url(forResource: "inCorrect", withExtension: ".wav")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("TEXT SOUND Error!!!")
        }
        audioPlayer.play()
    }
    
    func animalVoice(name:String) {
        let url = Bundle.main.url(forResource: name, withExtension: ".mp3")
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
        }catch{
            print("TEXT SOUND Error!!!")
        }
        
        audioPlayer.play()
    }
}
