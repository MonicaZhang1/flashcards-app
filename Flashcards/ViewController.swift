//
//  ViewController.swift
//  Flashcards
//
//  Created by Monica Zhang on 2/25/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //Destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //Navigation Controller only contains the Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //Set the flashcardsController property to self
        creationController.flashcardsController = self 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Style card
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true

        backLabel.layer.cornerRadius = 20.0
        backLabel.clipsToBounds = true
        
        //Style buttons
        buttonOne.clipsToBounds = true
        buttonOne.layer.cornerRadius = 20.0
        buttonOne.layer.borderWidth = 3.0
        buttonOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1) //use #colorLiteral()
        
        buttonTwo.clipsToBounds = true
        buttonTwo.layer.cornerRadius = 20.0
        buttonTwo.layer.borderWidth = 3.0
        buttonTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        buttonThree.clipsToBounds = true
        buttonThree.layer.cornerRadius = 20.0
        buttonThree.layer.borderWidth = 3.0
        buttonThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
    }

    @IBAction func didTapOnFlashcard(_ sender: Any){
        if (frontLabel.isHidden == false){
            frontLabel.isHidden = true
        }
        else{
            frontLabel.isHidden = false
        }
    }
    
    @IBAction func didTapOnButtonOne(_ sender: Any) {
        buttonOne.isHidden = true
    }
    
    @IBAction func didTapOnButtonTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOnButtonThree(_ sender: Any) {
        buttonThree.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String) {
    
        frontLabel.text = question
        backLabel.text = answer
    }
    
}

