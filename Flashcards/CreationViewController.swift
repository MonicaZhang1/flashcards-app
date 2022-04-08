//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Monica Zhang on 3/17/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAnswer1TextField: UITextField!
    
    @IBOutlet weak var extraAnswer2TextField: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialExtraAnswer1: String?
    var initialExtraAnswer2: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
        extraAnswer1TextField.text = initialExtraAnswer1
        extraAnswer2TextField.text = initialExtraAnswer2
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //Get the text in the question text field
        let questionText = questionTextField.text
        
        //Get the text in the answer text field
        let answerText = answerTextField.text
        
        let extraAnswer1Text = extraAnswer1TextField.text
        
        let extraAnswer2Text = extraAnswer2TextField.text
        
        //Check if empty
        if questionText == nil || answerText == nil || questionText!.isEmpty ||  answerText!.isEmpty || extraAnswer1Text == nil || extraAnswer2Text == nil || extraAnswer1Text!.isEmpty || extraAnswer2Text!.isEmpty{
            
            //Show error
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            //Dismiss alert
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }
        else {
            //See if it's existing
            var isExisting = false
            if initialQuestion != nil {
                isExisting = true
            }
            
            //Call the function to update the flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswer1: extraAnswer1Text!, extraAnswer2: extraAnswer2Text!, isExisting: isExisting)
        
            //Dismiss
            dismiss(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
