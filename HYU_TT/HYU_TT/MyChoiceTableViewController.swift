//
//  MyChoiceTableViewController.swift
//  HYU_TT
//
//  Created by isaac on 2017. 6. 6..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class MyChoiceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (Timer) in
            if ChoosenSub.isChanged == true {
                self.tableView.reloadData()
                ChoosenSub.isChanged = false
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
        return ChoosenSub.subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let thisSub = ChoosenSub.subjects[indexPath.row].0
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyChoiceCell", for: indexPath) as! TributeTableViewCell
        
        
        
        cell.subjectName.text = thisSub.nameOfLecture
        cell.numberOfLecture.text = thisSub.numberOfLecture
        
        cell.professor.append(cell.professor1)
        cell.professor.append(cell.professor2)
        cell.professor.append(cell.professor3)
        cell.professor.append(cell.professor4)
        
        cell.time.append(cell.time1)
        cell.time.append(cell.time2)
        cell.time.append(cell.time3)
        cell.time.append(cell.time4)
        
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
}

