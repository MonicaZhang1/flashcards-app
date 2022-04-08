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
    var extraAnswer1: String
    var extraAnswer2: String
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
        
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is the capital of Indonesia?", answer: "Jakarta", extraAnswer1: "Surabaya", extraAnswer2: "Bali", isExisting: false)
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any){
        flipFlashcard()
    }
    func flipFlashcard() {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight) {
            if (self.frontLabel.isHidden == false){
                self.frontLabel.isHidden = true
            }
            else{
                self.frontLabel.isHidden = false
            }
        }
    }
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: { finished in
            
            //Update labels
            self.updateLabels()
            
            //Run other animation
            self.animateCardIn()
        })
    }
    func animateCardIn(){
        
        //Start on the right side (don't animate)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        //Animate card going back to original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateCardOutPrevTap(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)}, completion: {
            finished in
            
            //Update labels
            self.updateLabels()
            
            //Run other animation
            self.animateCardInPrevTap()
        })
    }
    
    func animateCardInPrevTap(){
        
        //Start on the left side (don't animate)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        //Animate card going back to original position
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
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
        
        //Animate card out for previous
        animateCardOutPrevTap()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
        
        //Animate card out
        animateCardOut()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        //Show confirmation
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            action in
            self.deleteCurrentFlashcard()
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
     
    func deleteCurrentFlashcard(){
        
        //Delete current
        flashcards.remove(at: currentIndex)
        
        //Special case: Check if last card ws deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
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
    
    func updateFlashcard(question: String, answer: String, extraAnswer1: String, extraAnswer2: String, isExisting: Bool) {
        
        let flashcard = Flashcard(question: question, answer: answer, extraAnswer1: extraAnswer1, extraAnswer2: extraAnswer2)
        
        if isExisting {
            //Replace existing flashcard
            flashcards[currentIndex] = flashcard
        } else {
            
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
    }
    
    func saveAllFlashcardsToDisk() {

        //From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "extraAnswer1": card.extraAnswer1, "extraAnswer2": card.extraAnswer2]
        }

        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")

        //Log it
        print("Flashcards saved to UserDefaults")

    }
    
    func readSavedFlashcards(){

        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {

            //Know for sure there is a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswer1: dictionary["extraAnswer1"]!, extraAnswer2: dictionary["extraAnswer2"]!)
            }

            //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }

}

