//
//  SubjectSecondViewController.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 6. 1..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectSecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate {

    var parser = XMLParser()
    var category:[String] = ["교양인", "실용인", "외국어", "세계인", "영역외"]
    var selectedCategory = ""

    var isInit:Bool = false
    
    var passedCollegeName:String?
    var passedMajorName:String?
    var passedGrade:String?
    
    var selectedCollege:String?
    var selectedMajor:String?
    var seletedGrade:String?

    var tempSubject = Subject()
    var currentElement:String = ""

    
    @IBOutlet weak var liberalPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liberalPicker.delegate = self
        self.liberalPicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
//
//    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        /* change font size */
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }
        
        
        let data:String
        data = category[row]
        let attrData = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular)])
        label?.attributedText = attrData
        label?.textAlignment = .center
        
        return label!
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = category[row]

    }
    
    func parsingXMLData() {
        
        guard let file = Bundle.main.path(forResource: "major", ofType: "xml") else {
            print("cannot find file!")
            return
        }
        let url:URL = URL(fileURLWithPath: file)
        
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        let success:Bool = parser.parse()
        if (success) {
            return
        }
        else {
            print("parse failure!")
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement=elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        currentElement=""
    }
    
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //    if (currentElement == "NameOfCollege") { print (1) }
        if (isInit && currentElement == "NameOfCollege" && category.college.contains(string) == false) {
            category.college.append(string)
            return
        }

        
        switch currentElement {
        case "KindOfComplete":
            tempSubject.kindOfComplete = string
        case "Number":
            tempSubject.number = string
        case "NumberOfLecture":
            tempSubject.numberOfLecture = string
        case "NameOfLecture":
            tempSubject.nameOfLecture = string
        case "Credit":
            tempSubject.credit = string
        case "TheoryOrPractice":
            tempSubject.theoryOrPractice = string
        case "Time":
            tempSubject.time = string.components(separatedBy: ",")
        case "Place":
            tempSubject.place = string
        case "Professor":
            
            tempSubject.professor = string.components(separatedBy: ",")
            tempSubject.grade = string
            MySubjects.subjects.append(tempSubject)
            tempSubject = Subject()
        default: return
        }
        
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
