//
//  MyChoiceViewController.swift
//  HYU_TT
//
//  Created by isaac on 2017. 6. 10..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class MyChoiceViewController: UIViewController {

    @IBOutlet weak var totalCredit: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (Timer) in
            if ChoosenSub.totalCreditChanged == true {
                self.totalCredit.text = "총학점 : \(ChoosenSub.totalCredit)"
                
                ChoosenSub.totalCreditChanged = false
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func detail(_ sender: Any) {
        if Detail.subject != nil {
            let V2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
            self.addChildViewController(V2)
            self.view.addSubview(V2.view)
            V2.didMove(toParentViewController: self)
        }
    }
    @IBAction func make(_ sender: Any) {
        var title = ""
        var message = ""
        var okText = ""
        let timeTable = MakeTimeTables()
        let essentialList = MakeEssensialSubjectArray()
        var indexForTable = 0
        
        DatabaseManagement.MakedServeralTables.deleteTable()
        if(ChoosenSub.subjects.count != 0) {
            for table in timeTable {
                if (isBIncludedInA(A: table, B: essentialList)) {
                    for subjectNumber in table {
                        DatabaseManagement.MakedServeralTables.addSubject(subject: ChoosenSub.subjects[subjectNumber].subject, index: indexForTable)
                    }
                    indexForTable = indexForTable + 1
                }
            }
            
            if (indexForTable == 0) {
                title = "생성 실패"
                message = "조건을 만족하는 시간표가\n지구상에 존재하지 않습니다.\n필수 과목을 확인해 주세요^^;;"
                okText = "확인"
            }
            else {
                title = "생성 완료"
                message = "시간표가 만들어졌습니다!\n시간표 저장소 탭에서 확인하세요\u{1F496}"
                okText = "확인"
            }
        } else {
            title = "생성 실패"
            message = "듣고 싶은 과목을 선택해 주세요."
            okText = "확인"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okayButton)
        
        self.present(alert, animated: true, completion: nil)
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
