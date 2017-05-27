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

        //refresher = UIRefreshControl()
        //refresher.attributedTitle = NSAttributedString(string: "모르겠어")
        
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (Timer) in
            if MySubjects.isChanged == true {
                self.tableView.reloadData()
                print("refresh")
                MySubjects.isChanged = false
            }
        })
            
        
            /*refresher.addTarget(self, action: #selector(ChoiceTableViewController.refresh), for: UIControlEvents.valueChanged)
            tableView.addSubview(refresher)*/
        
        
        
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        
        // Configure the cell...

        return cell
    }
    
        
/*        tableView.reloadData()
        MySubjects.isChanged = false
        refresher.endRefreshing()*/

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisSub = MySubjects.subjects[indexPath.row]
        
        if let index = ChoosenSub.subjects.index(where: { (subject:Subject) -> Bool in
            subject.numberOfLecture == thisSub.numberOfLecture
            }) {
            ChoosenSub.subjects.remove(at: index)
        } else {
            ChoosenSub.subjects.append(thisSub)
        }
        
        self.tableView.reloadData()
        
        for sub in ChoosenSub.subjects {
            print(sub.nameOfLecture)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class TributeTableViewCell:UITableViewCell {
    
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var check: UIButton!
    
}

