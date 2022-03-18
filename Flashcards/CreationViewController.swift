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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        //Get the text in the question text field
        let questionText = questionTextField.text
        
        //Get the text in the answer text field
        let answerText = answerTextField.text
        
        //Check if empty
        if questionText == nil || answerText == nil || questionText!.isEmpty ||  answerText!.isEmpty{
            
            //Show error
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            
            //Dismiss alert
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            
            present(alert, animated: true)
        }
        else {
        
        //Call the fucntion to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
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
