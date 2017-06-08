//
//  ChoiceTableViewController.swift
//  HYU_TT
//
//  Created by isaac on 2017. 5. 26..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class ChoiceTableViewController: UITableViewController {
    
    //var refresher: UIRefreshControl!
    
    
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
            cell.subjectName.textColor = UIColor.blue
        } else {
            cell.subjectName.textColor = UIColor.black
        }
        
        
        cell.subjectName.text = thisSub.nameOfLecture
        cell.numberOfLecture.text = thisSub.numberOfLecture
        
        cell.professor.append(cell.professor1)
        cell.professor.append(cell.professor2)
        cell.professor.append(cell.professor3)
        cell.time.append(cell.time1)
        cell.time.append(cell.time2)
        cell.time.append(cell.time3)
        
        for i in 0...(thisSub.time.count - 1) {
            cell.time[i].text = thisSub.time[i]
        }
        for i in 0...(thisSub.professor.count - 1) {
            cell.professor[i].text = thisSub.professor[i]
        }
        
        cell.currentRow = indexPath.row

        return cell
    }


}

class TributeTableViewCell:UITableViewCell {
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var numberOfLecture: UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var professor1: UILabel!
    @IBOutlet weak var professor2: UILabel!
    @IBOutlet weak var professor3: UILabel!

    var currentRow:Int?
    
    var time:[UILabel] = []
    var professor:[UILabel] = []
    
    @IBAction func asd(_ sender: Any) {
        
        if let row = currentRow {
            let thisSub = MySubjects.subjects[row]
            if let index = ChoosenSub.subjects.index(where: { (subject:(Subject,Bool)) -> Bool in
                subject.0.numberOfLecture == thisSub.numberOfLecture
            }) {
                ChoosenSub.subjects.remove(at: index)
            } else {
                ChoosenSub.subjects.append((thisSub, true))
            }
            
            MySubjects.isChanged = true
            ChoosenSub.isChanged = true
            
            for sub in ChoosenSub.subjects {
                print(sub.0.nameOfLecture)
            }
    
        }
    }
    
}
