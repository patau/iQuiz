//
//  ViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 4/29/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit
import os.log

struct gData {
    static var gQuizzes: [Quiz] = []    //Quiz subjects
    static var data: Any?   //JSON data
    static var questions = [String:Any]()
    static var actualQuestions = [Int:[String]]()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    var quizzes = [Quiz]()
    @IBOutlet weak var settingsButton: UIBarButtonItem!
   // var answers = [[Answer]]() //For storing questions
    var answers = [Int : [Answer]]()
    var questionNum = 0
    var questions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        if url != nil {
            let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    _ = NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString!
                    do {
                        var jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
                        print("filling table called")
                        gData.data = jsonArray
                        ManageDatabase.fillTable(jsonArray: gData.data)
//                        print("Filling data")
//                        print(gData.gQuizzes)
//                        print("Printing out questions map")
//                        print(gData.questions)
                        
                        //Load sample data
                        self.loadSampleQuizzes()
                        DispatchQueue.main.async(){
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
        }


        //Settings button -> emoji
        self.settingsButton.title = NSString(string: "\u{2699}") as String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "quizCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomTableViewCell
        
        let quiz = quizzes[indexPath.row]
        cell.photoImageView.image = quiz.image
        cell.titleLabel.text = quiz.title
        cell.descLabel.text = quiz.desc
        
        print("cells cells cells")
        
        return cell
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        //Alert appearance
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var cellTitle: String = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
        cellTitle = cell.titleLabel.text!
        print("Set to \(cellTitle)")
        self.performSegue(withIdentifier: "ToQuestion", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let qPage = segue.destination as! QuizQuestionViewController
        let allQuestions = gData.questions[cellTitle]
        
        var index = 0
        var questionsArray = [String]()
        for singleQuestion in allQuestions as! [AnyObject] {
            print("Single question: \(singleQuestion)")
            questionsArray.append(singleQuestion["text"] as! String)
            gData.actualQuestions[0] = questionsArray as! [String]

            questions.append(singleQuestion["text"] as! String)
            let correctAnswer = singleQuestion["answer"]
            var putAnswers = [Answer]()
            var iteration = 0 //answers
            for answer in singleQuestion["answers"] as! [String] {
                iteration += 1
                if String(describing: correctAnswer) == "Optional(Optional(" + String(iteration) + "))" {
                    print("ANSWER LDSKFJLSDKJF")
                    print(String(describing: correctAnswer))
                    print(String(iteration))
                    putAnswers.append(Answer(text: answer, c: true))
                } else {
                    putAnswers.append(Answer(text: answer, c: false))
                }

                
            }
            answers[index] = putAnswers
            index += 1
            print(answers)
        }

        qPage.questionText = gData.actualQuestions[0]!
        qPage.answerText = answers

        
    }
    
    
    
    
    @IBAction func unwindToMainMenu(segue:UIStoryboardSegue) {
    }
    
    //MARK: Private functions
    private func loadSampleQuizzes() {
        //print("blan \(gData.gQuizzes)")
        quizzes = gData.gQuizzes
 
    }
}

