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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //item click event
        let handler = { (curriculum: CurriculaTableItem) in
            print(curriculum.name, curriculum.identifier)
        }
        
        //set data
        let infoSecA = CurriculaTableItem(name: "12", place: "ITBT", weekday: .monday, startPeriod: 1, endPeriod: 2, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0), identifier: "(2015-2016-2)-21190850", tapHandler: handler)
        
        let infoSecB = CurriculaTableItem(name: "910", place: "ITBT", weekday: .wednesday, startPeriod: 9, endPeriod: 10, textColor: UIColor.white, bgColor: UIColor(red: 1.0, green: 0.73, blue: 0.0, alpha: 1.0), identifier: "(2015-2016-2)-21190850", tapHandler: handler)
        
        let databaseA = CurriculaTableItem(name: "35", place: "ITBT", weekday: .tuesday, startPeriod: 3, endPeriod: 5, textColor: UIColor.white, bgColor: UIColor(red: 0.0, green: 0.83, blue: 0.62, alpha: 1.0), identifier: "(2015-2016-2)-21121350", tapHandler: handler)
        
        let databaseB = CurriculaTableItem(name: "Math", place: "ITBT", weekday: .friday, startPeriod: 1, endPeriod: 2, textColor: UIColor.white, bgColor: UIColor(red: 0.0, green: 0.83, blue: 0.62, alpha: 1.0), identifier: "(2015-2016-2)-21121350", tapHandler: handler)
        
        let comOrgA = CurriculaTableItem(name: "BasketBall", place: "ITBT", weekday: .monday, startPeriod: 3, endPeriod: 5, textColor: UIColor.white, bgColor: UIColor(red: 0.78, green: 0.49, blue: 0.87, alpha: 1.0), identifier: "(2015-2016-2)-21186033", tapHandler: handler)
        
        let comOrgB = CurriculaTableItem(name: "SoftwareStudio", place: "ITBT", weekday: .wednesday, startPeriod: 11, endPeriod: 12, textColor: UIColor.white, bgColor: UIColor(red: 0.78, green: 0.49, blue: 0.87, alpha: 1.0), identifier: "(2015-2016-2)-21186033", tapHandler: handler)
        
        //set data
        curriculaTable.curricula = [infoSecA, infoSecB, databaseA, databaseB, comOrgA, comOrgB]

        //view size settings
        curriculaTable.marginHeight = 10
        curriculaTable.boundWidth = 15
        
        //view settings
        curriculaTable.bgColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        curriculaTable.borderWidth = 0.5
        curriculaTable.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9)
        curriculaTable.cornerRadius = 5 //item courner radius
        curriculaTable.textEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2) //padding (when positive number)
        curriculaTable.maximumNameLength = 6
        
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
    
}

