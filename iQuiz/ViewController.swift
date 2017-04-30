//
//  ViewController.swift
//  iQuiz
//
//  Created by Patricia Au on 4/29/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var quizzes = [Quiz]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleQuizzes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "quizCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let quiz = quizzes[indexPath.row]
//        cell.photoImageView.image = quiz.image
//        cell.titleLabel.text = quiz.title
//        cell.descLabel.text = quiz.desc
        cell.textLabel?.text = quiz.title
        
        return cell
    }
    
    private func loadSampleQuizzes() {
        let photo = UIImage(named: "meeveryday")
        
        guard let quiz1 = Quiz(image: photo, title: "Mathematics", desc: "I haven't done math in three years") else {
            fatalError("Unable to instantiate quiz1")
        }
        
        guard let quiz2 = Quiz(image: photo, title: "Marvel Super Heroes", desc: "Don't you just wanna marvel at them? B)") else {
            fatalError("Unable to instantiate quiz2")
        }
        
        guard let quiz3 = Quiz(image: photo, title: "Science", desc: "Bears. Beets. Battlestar Galactica.") else {
            fatalError("Unable to instantiate quiz3")
        }
        
        quizzes += [quiz1, quiz2, quiz3]
    }
    
}

