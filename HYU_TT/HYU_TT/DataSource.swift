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
    static let map:[String:String] = ["H04":"사과대", "H05":"공학관1", "H06":"인문관","H07":"의과대본관","H08":"의학관1","H09":"의학관2","H10":"음악2","H11":"대학원,토건관","H12":"사범본관","H13":"공센","H14":"신소재공학관","H15":"부속병원본관","H17":"경금관","H21":"제1음악관","제H24":"의대계단동","H26":"백남음악관","H27":"공학관2","H32":"올체", "H33":"공센별관", "H34":"생과대","H36":"자과대","H37":"법학관1","H40":"과학기술","H43":"사범별관","H46":"산학기술","H47":"법학관2","H77":"ITBT","H88":"법학관3","H89":"경영관","H93":"퓨전테크", "H95":"행원파크"]
}


//복잡한 건물번호를 알아보기 쉽게 바꿔주는 함수
func changeBuildingNumberToName(buildingNumber : String) -> String {
    //H일 경우 미정
    if (buildingNumber == "") { return "" }
    if (buildingNumber == "H") { return "" }
    
    var result = ""
    //맵에 없을 경우 미정 리턴, 있을 경우 해당 번호에 맞는 건물이름 저장
    guard let nameOfBuilding = MapBuildingNumberToName.map[buildingNumber.substring(with: 0..<3)] else {
        return ""
    }
    //결과에 "건물이름 - "저장
    result += nameOfBuilding + " "
    
    //xml을 파싱하는 과정중에서 강의실이 한글일 때, H10- 에서 짤리므로 이 경우는 강의실을 따로 추가하지 않고 바로 리턴
    if (buildingNumber.characters.count == 4) { return result }
    //강의실번호
    let roomNumber:String
    //강의실번호 시작이 0일 경우 지상, B일 경우 지하
    switch buildingNumber.substring(with: 4..<5) {
    case "0":
        roomNumber = buildingNumber.substring(with: 5..<buildingNumber.characters.count)
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
    static var totalCredit:Int = 0
    static var totalCreditChanged:Bool = false
}

struct Category {
    var college:[String] = []
    var major:[String] = []
    var grade:[String] = []
    var subjects:[Subject] = []

    init() {}
}

struct Detail {
    static var subject:Subject?
}

struct clickedLectureInfo {
    static var nameForLecture:String = ""
}
