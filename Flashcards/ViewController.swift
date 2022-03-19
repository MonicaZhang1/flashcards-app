//
//  ViewController.swift
//  Flashcards
//
//  Created by Monica Zhang on 2/25/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        //Destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        //Navigation Controller only contains the Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        //Set the flashcardsController property to self
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        creationController.initialExtraAnswer1 = buttonOne.currentTitle
        creationController.initialExtraAnswer2 = buttonThree.currentTitle
        }
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
        
        updateFlashcard(question: "What is the capital of Indonesia?", answer: "Jakarta", extraAnswer1: "Surabaya", extraAnswer2: "Bali")
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        //Decrease current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    func updateLabels() {
        
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func updateNextPrevButtons() {
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        //Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswer1: String?, extraAnswer2: String?) {
    
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        buttonOne.setTitle(extraAnswer1, for: .normal)
        buttonTwo.setTitle(answer, for: .normal)
        buttonThree.setTitle(extraAnswer2, for: .normal)
        
        //Adding flashcard in the flashcards array
        flashcards.append(flashcard)
        
        //Logging to the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        //Update next and previous buttons
        updateNextPrevButtons()
        
        //Update labels
        updateLabels()
        
        //Save flashcards
        saveAllFlashcardsToDisk()
    }
    
    func saveAllFlashcardsToDisk() {

        //From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        //Log it
        print("Flashcards saved to UserDefaults")
        
    }
    
}

