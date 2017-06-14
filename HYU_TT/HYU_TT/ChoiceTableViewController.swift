//
//  ChoiceTableViewController.swift
//  HYU_TT
//
//  Created by isaac on 2017. 5. 26..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class ChoiceTableViewController: UITableViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (Timer) in
            if MySubjects.isChanged == true {
                self.tableView.reloadData()
                print("refresh")
                MySubjects.isChanged = false
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
            return MySubjects.subjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TributeTableViewCell
        let thisSub = MySubjects.subjects[indexPath.row]
        
        
        if ChoosenSub.subjects.index(where: { (subject:(Subject, Bool)) -> Bool in
            subject.0.numberOfLecture == thisSub.numberOfLecture
        }) != nil
        {
            cell.button.setImage(UIImage(named: "check.png"), for: .normal)
        } else {
            cell.button.setImage(UIImage(named: "plus.png"), for: .normal)
        }
        
        
        cell.subjectName.text = thisSub.nameOfLecture+"("+"\(CFStringGetIntValue(thisSub.credit as CFString!))"+")"
        cell.numberOfLecture.text = thisSub.numberOfLecture
        
        cell.time.append(cell.time1)
        cell.time.append(cell.time2)
        cell.time.append(cell.time3)
        cell.time.append(cell.time4)
        
        cell.professor.append(cell.professor1)
        cell.professor.append(cell.professor2)
        cell.professor.append(cell.professor3)
        cell.professor.append(cell.professor4)
        
        
        
        for i in 0...(thisSub.time.count - 1) {
            cell.time[i].text = thisSub.time[i]
            cell.professor[i].text = thisSub.professor[i]
        }
        if thisSub.time.count < 4 {
            for i in thisSub.time.count...3 {
                cell.time[i].text = ""
                cell.professor[i].text = ""
            }
        }
        
        cell.currentRow = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Detail.subject = MySubjects.subjects[indexPath.row]
    }
    


}

class TributeTableViewCell:UITableViewCell {
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var numberOfLecture: UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var time4: UILabel!
    @IBOutlet weak var professor1: UILabel!
    @IBOutlet weak var professor2: UILabel!
    @IBOutlet weak var professor3: UILabel!
    @IBOutlet weak var professor4: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var essential: UIButton!
    
    var currentRow:Int?
    
    var time:[UILabel] = []
    var professor:[UILabel] = []
    

    @IBAction func addClicked(_ sender: Any) {
        
        if let row = currentRow {
            let thisSub = MySubjects.subjects[row]
            if let index = ChoosenSub.subjects.index(where: { (subject:(Subject, Bool)) -> Bool in
                subject.0.numberOfLecture == thisSub.numberOfLecture
            }) {
                ChoosenSub.subjects.remove(at: index)
                if ChoosenSub.subjects.index(where: { (subject:(Subject, Bool)) -> Bool in
                    subject.0.number == thisSub.number
                }) == nil {
                    ChoosenSub.totalCredit = ChoosenSub.totalCredit - Int(CFStringGetIntValue(thisSub.credit as CFString))
                    ChoosenSub.totalCreditChanged = true
                }
            } else {
                if ChoosenSub.subjects.index(where: { (subject:(Subject, Bool)) -> Bool in
                    subject.0.number == thisSub.number
                }) == nil {
                    ChoosenSub.totalCredit = ChoosenSub.totalCredit + Int(CFStringGetIntValue(thisSub.credit as CFString))
                    ChoosenSub.totalCreditChanged = true
                }
                ChoosenSub.subjects.append((thisSub, false))
            }
            MySubjects.isChanged = true
            ChoosenSub.isChanged = true
        }
    }
    @IBAction func subClicked(_ sender: Any) {
        
        if let row = currentRow {
            let thisSub = ChoosenSub.subjects[row].0

            ChoosenSub.subjects.remove(at: row)
            if ChoosenSub.subjects.index(where: { (subject:(Subject, Bool)) -> Bool in
                subject.0.number == thisSub.number
            }) == nil {
                ChoosenSub.totalCredit = ChoosenSub.totalCredit - Int(CFStringGetIntValue(thisSub.credit as CFString))
                ChoosenSub.totalCreditChanged = true
            }
            
            MySubjects.isChanged = true
            ChoosenSub.isChanged = true
            for sub in ChoosenSub.subjects {
                print(sub.0.nameOfLecture)
            }
        }
    }
    @IBAction func essentilClicked(_ sender: Any) {
        if let row = currentRow {
            if ChoosenSub.subjects[row].1 == true {
                ChoosenSub.subjects[row].1 = false
            } else {
                ChoosenSub.subjects[row].1 = true
            }
            ChoosenSub.isChanged = true
        }
    }

    
}

