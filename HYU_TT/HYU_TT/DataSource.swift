//
//  DataSource.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 5. 25..
//  Copyright © 2017년 김나용. All rights reserved.
//

import Foundation


struct Subject {
    var grade:String
    var kindOfComplete:String
    var number:String
    var numberOfLecture:String
    var nameOfLecture:String
    var credit:String
    var theoryOrPractice:String
    var time:[String]
    var place:[String]
    var professor:[String]
    init() {
        grade = ""
        kindOfComplete = ""
        number = ""
        numberOfLecture = ""
        nameOfLecture = ""
        credit = ""
        theoryOrPractice = ""
        time = []
        place = []
        professor = []
    }
    init(grade:String, kindOfComplete:String, number:String, numberOfLecture:String, nameOfLecture:String, credit:String, theoryOrPractice:String, time:String, place:String, professor:String) {
        self.init()
        self.grade = grade
        self.kindOfComplete = kindOfComplete
        self.number = number
        self.numberOfLecture = numberOfLecture
        self.nameOfLecture = nameOfLecture
        self.credit = credit
        self.theoryOrPractice = theoryOrPractice
        self.time.append(time)
        self.place.append(place)
        self.professor.append(professor)
    }
}

struct MySubjects {
    static var subjects:[Subject] = []
    static var isChanged:Bool = false
}

struct ChoosenSub {
    static var subjects:[(subject : Subject,isessencial : Bool)] = []
    static var isChanged:Bool = false
}

struct Category {
    var college:[String] = []
    var major:[String] = []
    var grade:[String] = []
    var subjects:[Subject] = []

    init() {}
}
