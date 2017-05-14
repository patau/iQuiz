//
//  QuizQuestionViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 5/6/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class QuizQuestionViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var questionNum: Int = 0
    var questionText = [String]()
    var answerText = [Int:[Answer]]()
    var numCorrect = 0
    var answerChosen = 0
    var answersArray = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true

        print("In quiz question")
        print(questionText)
        print(answerText)
        
        if questionNum < questionText.count {
            question.text = questionText[questionNum]
            answersArray = [answer1, answer2, answer3, answer4]
            for index in 0...answersArray.count - 1 {
                print(index)
                answersArray[index].setTitle(answerText[questionNum]?[index].answerText, for: .normal)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func nextButtonPressed(_ sender: Any) {
    }
    
    
    var answerTitle = ""
    @IBAction func answer1Chosen(_ sender: Any) {
        answerTitle = ((sender as AnyObject).currentTitle!)!
        nextButton.isHidden = false
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToAnswer" {
            let aPage = segue.destination as! AnswerViewController
            aPage.questionNum = questionNum
            aPage.questionText = questionText
            aPage.answerText = answerText
            aPage.numCorrect = numCorrect
            aPage.answerChosen = answerTitle
        }
        
    }
    
    @IBAction func BackButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMainMenu", sender: self)
    }

    

    



}
