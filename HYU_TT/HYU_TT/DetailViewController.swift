//
//  DetailViewController.swift
//  HYU_TT
//
//  Created by isaac on 2017. 6. 9..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var nameOfLecture: UILabel!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var numberOfLecture: UILabel!
    @IBOutlet weak var kindOfComplete: UILabel!
    @IBOutlet weak var theoryOrPractice: UILabel!
    
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var time4: UILabel!
    @IBOutlet weak var place1: UILabel!
    @IBOutlet weak var place2: UILabel!
    @IBOutlet weak var place3: UILabel!
    @IBOutlet weak var place4: UILabel!
    @IBOutlet weak var professor1: UILabel!
    @IBOutlet weak var professor2: UILabel!
    @IBOutlet weak var professor3: UILabel!
    @IBOutlet weak var professor4: UILabel!
    
    var time:[UILabel] = []
    var place:[UILabel] = []
    var professor:[UILabel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        showAnimate()
        
        time.append(time1)
        time.append(time2)
        time.append(time3)
        time.append(time4)
        
        place.append(place1)
        place.append(place2)
        place.append(place3)
        place.append(place4)
        
        professor.append(professor1)
        professor.append(professor2)
        professor.append(professor3)
        professor.append(professor4)
        
        if let detailSubject = Detail.subject {
            nameOfLecture.text = detailSubject.nameOfLecture+"("+"\(CFStringGetIntValue(detailSubject.credit as CFString!))"+"학점)"
            
            grade.text = detailSubject.grade + "학년"
            
            number.text = "학수번호 : " + detailSubject.number
            
            numberOfLecture.text = "수업번호 : " + detailSubject.numberOfLecture
            
            kindOfComplete.text = detailSubject.kindOfComplete
            
            theoryOrPractice.text = detailSubject.theoryOrPractice
            
            for i in 0...(detailSubject.time.count - 1) {
                time[i].text = detailSubject.time[i]
                place[i].text = detailSubject.place[i]
                professor[i].text = detailSubject.professor[i]
            }
            if detailSubject.time.count < 4 {
                for i in detailSubject.time.count...3 {
                    time[i].text = ""
                    place[i].text = ""
                    professor[i].text = ""
                }
            }
        }
        
        

        // Do any additional setup after loading the view.
    }
    @IBAction func close(_ sender: Any) {
        Detail.subject = nil
        MySubjects.isChanged = true
        ChoosenSub.isChanged = true
        self.removeAnimate()
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: { 
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (finished : Bool) in
            if finished
            {
                self.view.removeFromSuperview()
            }
        }
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
