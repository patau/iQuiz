//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 5/12/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var rightOrWrong: UILabel!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var questionNum: Int = 0
    var questionText = [String]()
    var answerText = [Int:[Answer]]()
    var numCorrect = 0
    var answerChosen = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.isHidden = true
        question.text = questionText[questionNum]
        
        for element in answerText[questionNum]! {
            if element.answerText == answerChosen {
                if element.correct {
                    numCorrect += 1
                    rightOrWrong.text = "Correct!"
                } else {
                    rightOrWrong.text = "Wrong"
                }
            }
            if element.correct {
                answer.text = element.answerText
            }
        }
        if questionNum >= questionText.count - 1 {
            nextButton.isHidden = true
            finishButton.isHidden = false
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Continue" {
            let aPage = segue.destination as! QuizQuestionViewController
            aPage.questionNum = questionNum + 1
            aPage.questionText = questionText
            aPage.answerText = answerText
            aPage.numCorrect = numCorrect
        } else if segue.identifier == "Finish" {
            let fPage = segue.destination as! FinishedViewController
            fPage.totalQuestions = questionText.count
            fPage.numCorrect = numCorrect
        }
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMainMenu", sender: self)
    }


}
