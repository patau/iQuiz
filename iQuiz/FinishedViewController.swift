//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 5/12/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var scoreText: UILabel!

    var totalQuestions = 0
    var numCorrect = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if numCorrect == 0 {
            descText.text = "god you suck"
        } else if numCorrect == totalQuestions {
            descText.text = "way to go, champ!"
        } else {
            descText.text = "at least you didn't get 0"
        }
        scoreText.text = "\(numCorrect) out of \(totalQuestions) correct"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackToMain(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMainMenu", sender: self)
    }


}
