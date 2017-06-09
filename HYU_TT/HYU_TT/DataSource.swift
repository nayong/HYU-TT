//
//  DataSource.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 5. 25..
//  Copyright © 2017년 김나용. All rights reserved.
//

import Foundation

//건물 번호에 해당하는 건물 이름
struct MapBuildingNumberToName {
    static let map:[String:String] = ["H04":"사회과학관", "H05":"제1공학관", "H06":"인문관","H07":"의과대학 본관","H08":"제1의학관","H09":"제2의학관","H10":"제2음악관","H11":"대학원,토건관","H12":"사범대학본관","H13":"공업센터본관","H14":"신소재공학관","H15":"부속병원본관","H17":"경제금융관","H21":"제1음악관","H24":"의대계단 강의동","H26":"백남음악관","H27":"제2공학관","H32":"올림픽쳬육관", "H33":"공업센터별관", "H34":"생활과학관","H36":"자연과학관","H37":"제1법학관","H40":"과학기술관","H43":"사범대학 별관","H46":"산학기술관","H47":"제2법학관","H77":"정보통신관","H88":"제3법학관","H89":"경영관","H93":"퓨전테크놀로지", "H95":"행원파크"]
}


//복잡한 건물번호를 알아보기 쉽게 바꿔주는 함수
func changeBuildingNumberToName(buildingNumber : String) -> String {
    //H일 경우 미정
    if (buildingNumber == "H") { return "미정" }
    
    var result = ""
    //맵에 없을 경우 미정 리턴, 있을 경우 해당 번호에 맞는 건물이름 저장
    guard let nameOfBuilding = MapBuildingNumberToName.map[buildingNumber.substring(with: 0..<3)] else {
        return "미정"
    }
    //결과에 "건물이름 - "저장
    result += nameOfBuilding + " "
    
    //강의실번호
    let roomNumber:String
    //강의실번호 시작이 0일 경우 지상, B일 경우 지하
    switch buildingNumber.substring(with: 4..<5) {
    case "0":
        roomNumber = buildingNumber.substring(with: 5..<buildingNumber.characters.count) + "호"
    case "B":
        roomNumber = "지하" + buildingNumber.substring(with: 5..<buildingNumber.characters.count) + "호"
    default:
        roomNumber = buildingNumber.substring(with: 4..<buildingNumber.characters.count)
        
    }
    //결과에 강의실 번호 추가
    result += roomNumber
    return result
}

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
//카테고리에 맞는 과목을 저장하는 전역변수
struct MySubjects {
    static var subjects:[Subject] = []
    static var isChanged:Bool = false
}

//선택된 과목들을 저장하는 전역변수, isEssencial 은 필수과목인지 아닌지 확인해주는 Bool
struct ChoosenSub {
    static var subjects:[(subject : Subject,isEssencial : Bool)] = []
    static var isChanged:Bool = false
}

struct Category {
    var college:[String] = []
    var major:[String] = []
    var grade:[String] = []
    var subjects:[Subject] = []

    init() {}
}
