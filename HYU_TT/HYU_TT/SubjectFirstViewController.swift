//
//  SubjectFirstViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 17..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectFirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate {
    
    @IBOutlet weak var majorPicker: UIPickerView!
    var category = Category()
    var currentElement:String = ""
    
    var tempSubject = Subject()
    
    var parser = XMLParser()
    var isInit:Bool = false
    
    var passedCollegeName:String?
    var passedMajorName:String?
    var passedGrade:String?
    
    var selectedCollege:String?
    var selectedMajor:String?
    var seletedGrade:String?
    
    var collegeChanged:Bool = false
    var majorChanged:Bool = false
    var gradeChanged:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isInit = true
        parsingXMLData()
        isInit = false
        collegeChanged(collegeName: category.college[0])
        
        self.majorPicker.delegate = self
        self.majorPicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(component) {
        case 0: return category.college.count
        case 1: return category.major.count
        case 2: return category.grade.count
        default: return 0
        }
//        return majorCategories[component].count
    }
    
  
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        /* change font size */
        var label = view as! UILabel!
        if label == nil {
            label = UILabel()
        }

    
        let data:String
        switch(component) {
        case 0: data = category.college[row]
        case 1: data = category.major[row]
        case 2: data = category.grade[row]
        default: return label!
        }
        
        let attrData = NSAttributedString(string: data, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightRegular)])
        label?.attributedText = attrData
        label?.textAlignment = .center
        
        return label!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(component) {
        case 0:
            collegeChanged(collegeName: category.college[row])
            self.majorPicker.selectRow(0, inComponent: 1, animated: true)
            self.majorPicker.selectRow(0, inComponent: 2, animated: true)
        case 1: majorChanged(majorName: category.major[row])
            self.majorPicker.selectRow(0, inComponent: 2, animated: true)
        case 2: gradeChanged(grade: category.grade[row])
        default: return
        }
        self.majorPicker.delegate = self
        self.majorPicker.dataSource = self
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
    
    func collegeChanged(collegeName:String) {
        category.major = []
        collegeChanged = true
        selectedCollege = collegeName
        parsingXMLData()
        collegeChanged = false
        majorChanged(majorName: category.major[0])
        
        
    }
    
    func majorChanged(majorName:String) {
        category.grade = []
        majorChanged = true
        selectedMajor = majorName
        parsingXMLData()
        majorChanged = false
        gradeChanged(grade: category.grade[0])
    }
    
    func gradeChanged(grade:String) {
        MySubjects.subjects = []
        gradeChanged = true
        seletedGrade = grade
        parsingXMLData()
        gradeChanged = false
        MySubjects.isChanged = true

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
        
        if (currentElement == "NameOfCollege") { passedCollegeName = string }
            
        else if (currentElement == "NameOfMajor") {
            passedMajorName = string
            if (collegeChanged && passedCollegeName == selectedCollege && category.major.contains(string) == false) { category.major.append(string) }
        }
        else if (currentElement == "Grade") {
            passedGrade = string
            if (majorChanged && passedMajorName == selectedMajor && category.grade.contains(string) == false) { category.grade.append(string) }
        }
        
        if (gradeChanged && passedMajorName == selectedMajor && passedGrade == seletedGrade) {
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
                tempSubject.time = string
            case "Place":
                tempSubject.place = string
            case "Professor":
                
                tempSubject.professor = string
                tempSubject.grade = string
                MySubjects.subjects.append(tempSubject)
                tempSubject = Subject()
            default: return
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
