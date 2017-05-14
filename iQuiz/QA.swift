//
//  QA.swift
//  iQuiz
//
//  Created by Patricia Au on 5/12/17.
//  Copyright © 2017 Patricia Au. All rights reserved.
//

import Foundation

class Answer {
    var answerText: String
    var correct: Bool
    
    init(text: String, c: Bool) {
        answerText = text
        correct = c
    }
}
class QA {
    var quizName: String
    var question = [[Any]]()
    var answered = [Answer]() //answerText: what user answered; correct: whether answered correctly
    
    init(qn: String, q: [[Any]]) {
        quizName = qn
        question = q

    }
}
