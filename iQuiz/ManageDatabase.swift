//
//  ManageDatabase.swift
//  iQuiz
//
//  Created by Patricia Au on 5/14/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import UIKit
import SQLite

//struct gData {
//    static var gQuizzes: [Quiz] = []
//}

class ManageDatabase: NSObject {
    
    public static let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/db.sqlite3"
    
    static func createDBIfNeeded() {
        let url = NSURL(fileURLWithPath: ManageDatabase.filePath)
        print(url)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: url.path!) {
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
            do {
                let db = try Connection(filePath)
                //ManageDatabase.createQuizTable(db: db)
                //ManageDatabase.createQuestionTable(db: db)
                //ManageDatabase.createAnswersTable(db: db)
                //grabData()
                
            } catch {
                print("exception connecting to db")
            }
        }
        print("grabbing data")
        //grabData()

    }
    
//    static func createQuizTable(db: Connection) {
//        let quizzes = Table("Quizzes")
//        let id = Expression<Int64>("id")
//        let quizName = Expression<String?>("quizName")
//        let quizDesc = Expression<String?>("quizDesc")
//        let questions = Expression<[String]>("questions")
//        let answer = Expression<Int64>("answer")
//        
//        
//        do {
//            try db.run(quizzes.create { t in
//                t.column(id, primaryKey: true)
//                t.column(quizName)
//                t.column(quizDesc)
//                t.column(questions)
//                t.column(answer)
//            })
//        } catch {
//            print("exception creating db - quizzes")
//        }
//    }
    /*
    static func createQuestionTable(db: Connection) {
        let questions = Table("Questions")
        let id = Expression<Int64>("id")
        let quizID = Expression<Int64>("quizID")
        let answer = Expression<Int64>("answer")
        let questionText = Expression<String?>("questionText")
        do {
            try db.run(questions.create { t in
                t.column(id, primaryKey: true)
                t.column(quizID)
                t.column(questionText)
                t.column(answer)
            })
        } catch {
            print("exception creating db - questions")
        }
    }
    
    static func createAnswersTable(db: Connection) {
        let answers = Table("Answers")
        let id = Expression<Int64>("id")
        let questionID = Expression<Int64>("questionID")
        let answerText = Expression<String?>("answerText")
        let order = Expression<Int64>("order")
        do {
            try db.run(answers.create { t in
                t.column(id, primaryKey: true)
                t.column(questionID)
                t.column(answerText)
                t.column(order)
            })
        } catch {
            print("exception creating db - answers")
        }
    }
 */
    
    static func getDB() -> Connection? {
        do {
            let db = try Connection(filePath)
            return db
        } catch {
            return nil
        }
    }
    

    /*
    static func grabData(){
        let db = ManageDatabase.getDB()
        var sendData: (Any)? = nil
        
        let url = NSURL(string: "http://tednewardsandbox.site44.com/questions.json")
        if url != nil {
            let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    _ = NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString!
                    do {
                        var jsonArray = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions())
                        //print("data = jsonArray")
                        //sendData = jsonArray
                        print("filling table called")
                        ManageDatabase.fillTable(jsonArray: jsonArray)

//                        for quizQuestion in jsonArray as! [AnyObject] {
//                            let quizTitle = quizQuestion.value(forKey: "title")!
//                            let quizDesc = quizQuestion.value(forKey: "desc")!
//                            let quizQuestion = quizQuestion.value(forKey: "questions")!
//
//                            //var quiz = Quiz(image: nil, title: quizTitle as! String, desc: quizDesc as! String)
//                            
//                            for questionSet in quizQuestion as! Array<AnyObject> {
//                                var question = questionSet["text"] as! String
//                                var answer = questionSet["answer"] as! String
//                                for answer in questionSet["answers"] as! Array<String> {
//                                    print(answer)
//                                }
//                            }
//                            
//                            try db!.run("INSERT INTO Quizzes (quizName, quizDesc) VALUES ('\(quizTitle)', '\(quizDesc)')")
//                            //try db!.run("SELECT FROM Quizzes id WHERE quizName = '\(quizTitle)')")
//                        }
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
        }
        
    }
 */
    
    static func fillTable(jsonArray: Any) -> [Quiz] {
        //let db = ManageDatabase.getDB()
        print("in fill table")
        var quizzes = [Quiz]()
        
        for quizQuestion in jsonArray as! [AnyObject] {
            
            
            let quizTitle = quizQuestion.value(forKey: "title")!
            let quizDesc = quizQuestion.value(forKey: "desc")!
            let quizQuestion = quizQuestion.value(forKey: "questions")!
            
            var quiz = Quiz(image: nil, title: quizTitle as! String, desc: quizDesc as! String)
            
            
            quizzes.append(quiz!)
            gData.questions[String(describing: quizTitle)] = quizQuestion
        }
        gData.gQuizzes = quizzes
//        let state = gData.gQuizzes
//        print(state)
        
        return quizzes
    }

    
//    func insertIntoDB() {
//        let db = ManageDatabase.getDB()
//        do {
//            let insert = users.insert(name <- "Alice", email <- "alice@mac.com")
//            let rowid = try db.run(insert)
//        }
//    }

}
