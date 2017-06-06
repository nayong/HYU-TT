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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyChoiceCell", for: indexPath) as! MyChoiceTableViewCell

        let thisSub = ChoosenSub.subjects[indexPath.row]
        
        cell.subjectName.text = thisSub.nameOfLecture
        
        return cell
    }


}

class MyChoiceTableViewCell:UITableViewCell {
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var check: UIButton!
    
    var currentRow:Int?
}

