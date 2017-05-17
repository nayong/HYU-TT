//
//  SubjectFirstViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 17..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectFirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var majorPicker: UIPickerView!
    var majorCategories = [["공과대학", "인문대학", "의과대학"],
                           ["컴퓨터공학부", "전기생체공학과", "기계공학과", "건축학과"],
                           ["1학년", "2학년", "3학년", "4학년"]]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.majorPicker.delegate = self
        self.majorPicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return majorCategories[component].count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        
//        var label = view as! UILabel!
//        if label == nil {
//            label = UILabel()
//        }
//        
//        let data = majorCategories[component][row]
//        let attrData = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 36.0, weight: UIFontWeightRegular)])
//        label?.attributedText = attrData
//        label?.textAlignment = .center
//        
//        return label
//    }
//    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        /* change font size */
            var label = view as! UILabel!
            if label == nil {
                label = UILabel()
            }
    
            let data = majorCategories[component][row]
            let attrData = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular)])
            label?.attributedText = attrData
            label?.textAlignment = .center
            
            return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(majorCategories[component][row])
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
