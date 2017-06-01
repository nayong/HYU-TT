//
//  SubjectViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 17..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectViewController: UIViewController {
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!

    var majorSubjects:[Subject] = []
    var liberalSubjects:[Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /* 전공/교양 따라 페이지 바꿈 */
    @IBAction func showContainer(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            self.liberalSubjects = MySubjects.subjects
            MySubjects.subjects = self.majorSubjects
            MySubjects.isChanged = true
            UIView.animate(withDuration: 0.5, animations: {
                    self.firstView.alpha = 0.0
                    self.secondView.alpha = 1.0
            })
        }else{
            self.majorSubjects = MySubjects.subjects
            MySubjects.subjects = self.liberalSubjects
            MySubjects.isChanged = true
            UIView.animate(withDuration: 0.5, animations: {
                self.firstView.alpha = 1.0
                self.secondView.alpha = 0.0
            })
        }
        
        
    }

}
