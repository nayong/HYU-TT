//
//  StorageViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 6. 10..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
import CurriculaTable

class StorageViewController: UIViewController {
    
    var subjects:[[Subject]] = []
    var clickedIndex:Int = -1
    var clickedIndexPath:IndexPath = []
    let colorBlue:UIColor = UIColor(red: 0.55, green: 0.55, blue: 0.88, alpha: 0.1)
    let colorTrasparent:UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
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
    var totalCredit = 0

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjects = DatabaseManagement.MakedServeralTables.queryAllProduct()
        self.collectionView.reloadData()
        
        
//        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: {
//            (Timer) in
//            if true {
//            }
//        })
//        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.subjects = DatabaseManagement.MakedServeralTables.queryAllProduct()
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension StorageViewController : UICollectionViewDataSource, UICollectionViewDelegate, BEMCheckBoxDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.collectionView.delegate = self
        return subjects.count
    }
    
    //@available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        totalCredit = 0
        
        //cell setting
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StorageCellCollectionViewCell
        collectionView.isUserInteractionEnabled = true
        let cellSize = CGSize(width: CGFloat((collectionView.frame.size.width / 1) - 20), height: CGFloat(100))
        cell.sizeThatFits(cellSize)
        
        setTable(curriculaTable: cell.curriculaTable)
        setData(curriculaTable: cell.curriculaTable, index: indexPath.item)
        
        cell.creditLabel.text = String(totalCredit)
        
        cell.checkBox.delegate = self
        cell.checkBox.isEnabled = false
        
        //for clicked initialize
        clickedIndex = -1
        cell.background.backgroundColor = colorTrasparent
        cell.checkBox.isHidden = true
        cell.checkBox.setOn(false, animated: true)
        
        
//        //touch event
//        let touchGesture = UITapGestureRecognizer(target: self, action: #selector(StorageViewController.tableTapped(sender:)))
//        cell.curriculaTable.addGestureRecognizer(touchGesture)
    

//        
        //delete
        //self.setEditing(true, animated: true)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        //for select item at once
        if(clickedIndex != -1){
            print("clickedIndex != -1")
            let beforeCell = collectionView.cellForItem(at: clickedIndexPath) as! StorageCellCollectionViewCell
            beforeCell.background.backgroundColor = colorTrasparent
            beforeCell.checkBox.isHidden = true
            beforeCell.checkBox.setOn(false, animated: true)
        }
        
        print("indexPath : \(indexPath)")
        print("clickedIndexPath : \(clickedIndexPath)")
        
        let mCell:StorageCellCollectionViewCell = collectionView.cellForItem(at: indexPath) as! StorageCellCollectionViewCell
        
        if (clickedIndexPath == indexPath) && (mCell.background.backgroundColor == colorBlue){
            mCell.background.backgroundColor = colorTrasparent
            mCell.checkBox.isHidden = true
            mCell.checkBox.setOn(false, animated: true)
        } else if (clickedIndexPath != indexPath) && (mCell.background.backgroundColor == colorBlue) {
            mCell.background.backgroundColor = colorTrasparent
            mCell.checkBox.isHidden = true
            mCell.checkBox.setOn(false, animated: true)
        } else {
            mCell.background.backgroundColor = colorBlue
            mCell.checkBox.isHidden = false
            mCell.checkBox.setOn(true, animated: true)
        }
        clickedIndexPath = indexPath
        clickedIndex = indexPath.item
        
        //set data
        let set = subjects[indexPath.item]
        for _ in 0..<DatabaseManagement.SeletedTable.queryAllProduct().count{
            DatabaseManagement.SeletedTable.deleteTable()
        }
        for subject in set {
            DatabaseManagement.SeletedTable.addSubject(subject: subject, index: 0)
        }
        //self.collectionView.deleteItems(at: [clickedIndex])
    }
    
//    func tableTapped(sender: UITapGestureRecognizer){
//        print("tapped")
//    }
//    
    func setTable(curriculaTable :CurriculaTable){
        
        //view settings
        curriculaTable.bgColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        curriculaTable.weekdaySymbolType = .veryShort
        curriculaTable.symbolsFontSize = 6
        curriculaTable.showPlace = false
        curriculaTable.borderWidth = 0.5
        curriculaTable.borderColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.0)
        curriculaTable.cornerRadius = 3 //item courner radius
        curriculaTable.textFontSize = 7
        curriculaTable.textEdgeInsets = UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 1.5) //padding (when positive number)
        curriculaTable.maximumNameLength = 15
        
    }
    
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
    
    func setData(curriculaTable :CurriculaTable, index: Int){
        
        //Subject 불러 올 때
//        subjects = DatabaseManagement.MakedServeralTables.queryAllProduct()
        
        let handler = { (curriculum: CurriculaTableItem) in }
        
        //각 강의들을 시간표에 맞는 struct로 바꾼 배열
        var tableItemArray:[CurriculaTableItem] = []
        
        let set = subjects[index]
 
        totalCredit = 0
        
        for subject in set {
            //time 배열을 (요일, 시작 시간, 끝나는 시간) 배열로 바꿈
            let periods = getTime(time:subject.time)
            totalCredit = totalCredit + Int(CFStringGetIntValue(subject.credit as CFString))
            //time 배열의 수만큼 for문을 돌면서 시간표에 맞는 struct로 바꾸고, 배열에 넣어줌
            for indexForTime in 0..<subject.time.count {
                tableItemArray.append(CurriculaTableItem(name: subject.nameOfLecture, place: subject.place[indexForTime],weekday: CurriculaTableWeekday(rawValue: getWeekday(weekday: periods[indexForTime].weekday))!
                    , startPeriod: periods[indexForTime].start, endPeriod: periods[indexForTime].end, textColor: UIColor.white, bgColor: colors[colorIndex], identifier: "20393", tapHandler: handler))
            }
            colorIndex = (colorIndex + 1) % 12
        }
        colorIndex = 0
        
//        //불러온 Table 을 과목 하나씩 돌기
//        for set in subjects {
//            for subject in set {
//                //time 배열을 (요일, 시작 시간, 끝나는 시간) 배열로 바꿈
//                let periods = getTime(time:subject.time)
//                //time 배열의 수만큼 for문을 돌면서 시간표에 맞는 struct로 바꾸고, 배열에 넣어줌
//                for indexForTime in 0..<subject.time.count {
//                    tableItemArray.append(CurriculaTableItem(name: subject.nameOfLecture, place: subject.place[indexForTime],weekday: CurriculaTableWeekday(rawValue: getWeekday(weekday: periods[indexForTime].weekday))!
//                        , startPeriod: periods[indexForTime].start, endPeriod: periods[indexForTime].end, textColor: UIColor.white, bgColor: UIColor(red: 0.78, green: 0.49, blue: 0.87, alpha: 1.0), identifier: "20393", tapHandler: handler))
//                }
//            }
//        }
        
        //set data
        for item1 in tableItemArray{
            print("tableItemArray"+item1.name)
        }
        curriculaTable.curricula = tableItemArray
        
    }

}
