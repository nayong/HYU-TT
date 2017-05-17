//
//  TimeTableViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 18..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class TimeTableViewController: UICollectionViewController {
    
    var Array = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Array = ["OS","","","OS","",
                 "","","Software Studio","","",
                 "","Software Studio","Automata","OS","Automata",
            "Automata","","","",""
        ]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as UICollectionViewCell
        
        var item = cell.viewWithTag(1) as! UILabel
    
        item.text = Array[indexPath.row]
        if(item.text == "OS"){
            cell.backgroundColor = UIColor(red: 50/256, green: 200/256, blue: 200/256, alpha: 0.20)
        }else if(item.text == "Software Studio"){
                        cell.backgroundColor = UIColor(red: 200/256, green: 200/256, blue: 50/256, alpha: 0.20)
        }else if(item.text == "Automata"){
                                    cell.backgroundColor = UIColor(red: 200/256, green: 50/256, blue: 200/256, alpha: 0.20)
        }
        else{
            cell.backgroundColor = UIColor(red: 200/256, green: 200/256, blue: 200/256, alpha: 0.10)
            }
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
