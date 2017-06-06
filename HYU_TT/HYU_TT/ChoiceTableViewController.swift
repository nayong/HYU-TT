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
        
        if ChoosenSub.subjects.index(where: { (subject:Subject) -> Bool in
            subject.numberOfLecture == thisSub.numberOfLecture
        }) != nil
        {
            cell.subjectName.textColor = UIColor.blue
        } else {
            cell.subjectName.textColor = UIColor.black
        }
        
        cell.subjectName.text = thisSub.nameOfLecture
        

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisSub = MySubjects.subjects[indexPath.row]
        
        if let index = ChoosenSub.subjects.index(where: { (subject:Subject) -> Bool in
            subject.numberOfLecture == thisSub.numberOfLecture
            }) {
            ChoosenSub.subjects.remove(at: index)
        } else {
            ChoosenSub.subjects.append(thisSub)
        }
        
        ChoosenSub.isChanged = true
        self.tableView.reloadData()
        
        for sub in ChoosenSub.subjects {
            print(sub.nameOfLecture)
        }
    }

}

class TributeTableViewCell:UITableViewCell {
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var check: UIButton!
    
    var currentRow:Int?
    
}

