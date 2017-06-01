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
  var place:String
  var professor:String
  init() {
    grade = ""
    kindOfComplete = ""
    number = ""
    numberOfLecture = ""
    nameOfLecture = ""
    credit = ""
    theoryOrPractice = ""
    time = []
    place = ""
    professor = ""
  }
}

struct MySubjects {
    static var subjects:[Subject] = []
    static var isChanged:Bool = false
}

struct ChoosenSub {
    static var subjects:[Subject] = []
}

struct Category {
  var college:[String] = []
  var major:[String] = []
  var grade:[String] = []
  var subjects:[Subject] = []
  
  init() {}
}
