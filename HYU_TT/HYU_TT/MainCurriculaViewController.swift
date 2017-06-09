//
//  MainCurriculaViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 6. 8..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
import CurriculaTable

class MainCurriculaViewController: UIViewController {
    
    @IBOutlet weak var curriculaTable: CurriculaTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = Subject()
        DatabaseManagement.MakedServeralTables.deleteTable()
        temp.numberOfLecture = "15607"
        temp.nameOfLecture = "소프트웨어 스튜디오"
        temp.professor = ["링고스타"]
        temp.place = ["ITBT 508호"]
        temp.time = ["금(11:00-13:00)"]
        DatabaseManagement.MakedServeralTables.addSubject(subject: temp, index: 0)
//        

//        //Subject 불러 올 때
        let subjects = DatabaseManagement.MakedServeralTables.queryAllProduct()
        
        let handler = { (curriculum: CurriculaTableItem) in }
        
        //각 강의들을 시간표에 맞는 struct로 바꾼 배열
        var tableItemArray:[CurriculaTableItem] = []
        
        //불러온 Table 을 과목 하나씩 돌기
        for subject in subjects[0] {
            
            //time 배열을 (요일, 시작 시간, 끝나는 시간) 배열로 바꿈
            let periods = getTime(time:subject.time)
            
            //time 배열의 수만큼 for문을 돌면서 시간표에 맞는 struct로 바꾸고, 배열에 넣어줌
            for indexForTime in 0..<subject.time.count {
                tableItemArray.append(CurriculaTableItem(name: subject.nameOfLecture, place: subject.place[indexForTime],weekday: CurriculaTableWeekday(rawValue: getWeekday(weekday: periods[indexForTime].weekday))!
, startPeriod: periods[indexForTime].start, endPeriod: periods[indexForTime].end, textColor: UIColor.white, bgColor: UIColor(red: 0.78, green: 0.49, blue: 0.87, alpha: 1.0), identifier: "20393", tapHandler: handler))
                
            }
        }
        
        //set data
        curriculaTable.curricula = tableItemArray
        
        //view settings
        curriculaTable.marginHeight = 100
        curriculaTable.marginY = -65
        curriculaTable.bgColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        curriculaTable.borderWidth = 0.5
        curriculaTable.borderColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        curriculaTable.cornerRadius = 3 //item courner radius
        curriculaTable.textFontSize = 11
        curriculaTable.textEdgeInsets = UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 1.5) //padding (when positive number)
        curriculaTable.maximumNameLength = 15
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getTime (time :[String]) -> [(weekday: String, start: Int, end: Int)]{
        
        var times:[(String, Int, Int)] = []
        var weekday:String, time1:Int, time2:Int
        
        for i in 0..<time.count{
            
            let mTime:String = time[i]
            weekday = mTime.substring(with: 0..<1)
            
            time1 = Int(mTime.substring(with:2..<4))!
            if(mTime.substring(with:5..<6) != "0"){
                time1 = 2*time1 - 16
            }else{
                time1 = 2*time1 - 17
            }
            
            time2 = Int(mTime.substring(with:8..<10))!
            if(mTime.substring(with:11..<12) != "0"){
                time2 = 2*time2 - 16
            }else{
                time2 = 2*time2 - 17
            }
            
            times.append((weekday, time1, time2))
            
            //요일 -> .요일
            //시간 -> startPeriod 3~5 == 10, 10.5, 11
            //9 - 1 / 9:30 - 2 / 10 - 3 / 10.5 - 4 / 11 - 5
            // 시 : (2(h-8)-1) = 2h - 17
            // 분 : !=0 -> 2h-16
        }
        
        return times
    }
    
    func getWeekday (weekday: String) -> Int {
        var newWeekday = 0
        if(weekday == "월"){
            newWeekday = 2
        }else if(weekday == "화"){
            newWeekday = 3
        }else if(weekday == "수"){
            newWeekday = 4
        }else if(weekday == "목"){
            newWeekday = 5
        }else if(weekday == "금"){
            newWeekday = 6
        }else if(weekday == "토"){
            newWeekday = 1
        }
        return newWeekday
    }
    
}

