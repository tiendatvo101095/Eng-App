//
//  LessonViewController.swift
//  Eng-App
//
//  Created by DXC-Technology on 11/20/17.
//  Copyright © 2017 DXC-Technology. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var answer: UILabel!
    
    var imageArray = ["question-lion.jpg", "question-tiger.jpg", "question-snake.jpg", "question-dog.jpg", "question-cat.jpg", "question-elephant.jpg", "question-camel.jpg"]
    
    let vocabulary = ["lion", "tiger", "snake", "dog", "cat", "elephant", "camel"]
    
    var checkAnswer:Bool!
    var playerPoint:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImage() {
        if (imageArray.count > 0) {
            let randomImage = Int(arc4random_uniform(UInt32(imageArray.count)))
            let myImage = imageArray[randomImage]
            imgPicture.image = UIImage(named: myImage)
            imageArray.remove(at: randomImage)
            
            let randomAnswer = Int(arc4random_uniform(UInt32(vocabulary.count)))
            let myAnswer = vocabulary[randomAnswer]
            answer.text = myAnswer
            
            if (myImage == "question-" + myAnswer + ".jpg") {
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
    
    func compareAnswer(correctValue:Bool, playerValue:Bool) {
        if (correctValue == playerValue) {
            playerPoint = playerPoint + 1
        }
        createImage()
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
}
