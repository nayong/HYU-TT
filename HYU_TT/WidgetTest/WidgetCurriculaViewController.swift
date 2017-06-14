//
//  WidgetCurriculaViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 6. 8..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
import CurriculaTable


class WidgetCurriculaViewController: UIViewController {
    @IBOutlet weak var curriculaTable: CurriculaTable!
    let colors:[UIColor] = [
        UIColor(red:0.27, green:0.70, blue:0.62, alpha:1.0),
        UIColor(red:0.94, green:0.79, blue:0.30, alpha:1.0),
        UIColor(red:0.89, green:0.48, blue:0.25, alpha:1.0),
        UIColor(red:0.87, green:0.35, blue:0.29, alpha:1.0),
        UIColor(red:0.29, green:0.44, blue:0.53, alpha:1.0),
        UIColor(red:0.56, green:0.40, blue:0.64, alpha:1.0),
        UIColor(red:0.38, green:0.70, blue:0.40, alpha:1.0),
        UIColor(red:0.94, green:0.68, blue:0.21, alpha:1.0),
        UIColor(red:0.89, green:0.44, blue:0.36, alpha:1.0),
        UIColor(red:0.87, green:0.44, blue:0.49, alpha:1.0),
        UIColor(red:0.25, green:0.64, blue:0.53, alpha:1.0),
        UIColor(red:0.70, green:0.70, blue:0.28, alpha:1.0)
    ]
    var colorIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("widget appear")
        //Subject 불러 올 때
        let subjects = DatabaseManagement.SeletedTable.queryAllProduct()
        let handler = { (curriculum: CurriculaTableItem) in }
        print("widget subjects[0] ::: " + String(subjects[0].count))
        //각 강의들을 시간표에 맞는 struct로 바꾼 배열
        var tableItemArray:[CurriculaTableItem] = []
        
        //불러온 Table 을 과목 하나씩 돌기
        let index = 0
        for subject in subjects[index] {
            print("widget ::: subject.name" + String(subject.nameOfLecture))
            //time 배열을 (요일, 시작 시간, 끝나는 시간) 배열로 바꿈
            let periods = getTime(time:subject.time)
            //time 배열의 수만큼 for문을 돌면서 시간표에 맞는 struct로 바꾸고, 배열에 넣어줌
            for indexForTime in 0..<subject.time.count {
                tableItemArray.append(CurriculaTableItem(name: subject.nameOfLecture, place: subject.place[indexForTime],weekday: CurriculaTableWeekday(rawValue: getWeekday(weekday: periods[indexForTime].weekday))!
                    , startPeriod: periods[indexForTime].start, endPeriod: periods[indexForTime].end, textColor: UIColor.white, bgColor: colors[colorIndex], identifier: "20393", tapHandler: handler))
            }
            colorIndex = (colorIndex + 1) % 12
        }
        colorIndex = 0
        //set data
        setTable()
        print("widget ::: " + String(tableItemArray.count))
        curriculaTable.curricula = tableItemArray
        //self.curriculaTable.reloadInputViews()
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
                time2 = 2*time2 - 17
            }else{
                time2 = 2*time2 - 18
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
    
    func setTable(){
        
        curriculaTable.marginHeight = 30
        curriculaTable.boundWidth = 19
        
        
        //view settings
        curriculaTable.bgColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        curriculaTable.borderWidth = 0.5
        curriculaTable.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
        curriculaTable.cornerRadius = 5 //item courner radius
        curriculaTable.textEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //padding (when positive number)
        curriculaTable.maximumNameLength = 10
        curriculaTable.textFontSize = 9
        
    }
    
}
