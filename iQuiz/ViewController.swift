//
//  ViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 4/29/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    var quizzes = [Quiz]()
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load sample data
        loadSampleQuizzes()
        
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
        
        return cell
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        //Alert appearance
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Private functions
    private func loadSampleQuizzes() {
        let dwight = UIImage(named: "meeveryday")
        let kevin = UIImage(named: "kevin")
        let michael = UIImage(named: "scott")
        
        guard let quiz1 = Quiz(image: kevin, title: "Mathematics", desc: "Many small time make big time.") else {
            fatalError("Unable to instantiate quiz1")
        }
        
        guard let quiz2 = Quiz(image: michael, title: "Marvel Super Heroes", desc: "Am I a hero? I can't really say, but yes.") else {
            fatalError("Unable to instantiate quiz2")
        }
        
        guard let quiz3 = Quiz(image: dwight, title: "Science", desc: "Bears. Beets. Battlestar Galactica.") else {
            fatalError("Unable to instantiate quiz3")
        }
        
        quizzes += [quiz1, quiz2, quiz3]
    }
    
}

