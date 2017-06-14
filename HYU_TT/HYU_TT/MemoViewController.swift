//
//  MemoViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 6. 14..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var nameOfLecture: UILabel!
    var name:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfLecture.text = name
        if let memo = MemoDatabaseManagement.MakedMemoDB.queryForSubjectMemo(nameOfClickedLecture: nameOfLecture.text!) {
            contents.text = memo
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func write(_ sender: Any) {
        MemoDatabaseManagement.MakedMemoDB.deleteSubjectMemoInTable(nameOfClickedLecture: nameOfLecture.text!)
        MemoDatabaseManagement.MakedMemoDB.addSubject(nameOfClickedLecture: nameOfLecture.text!, memo: contents.text!)
        dismiss(animated: true, completion: nil)
        
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
