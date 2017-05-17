//
//  Quiz.swift
//  iQuiz
//
//  Created by Patricia Au on 4/30/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit

class Quiz {
    
    //MARK: Properties
    var image: UIImage?
    var title: String
    var desc: String
    
    //MARK: Initialization
    init?(image: UIImage?, title: String, desc: String) {
        if title.isEmpty || desc.isEmpty {
            return nil
        }
        self.image = image
        self.title = title
        self.desc = desc
    }
    
    func insertIntoDB() {
        let db = ManageDatabase.getDB()
        do {
            try db!.run("INSERT INTO Quiz (quizTitle, quizDesc) VALUES ('\(self.title)', '\(self.desc)')")
        } catch {
            print("Error inserting into db")
        }
    }
}
