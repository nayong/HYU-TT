//
//  SubjectFirstViewController.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 5. 17..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
/*                                        전공 카테고리                        */
class SubjectFirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate {
    
    @IBOutlet weak var majorPicker: UIPickerView!
    //탐색 카테고리 (대학 , 전공 , 학년)
    var category = Category()
    //xml 탐색 시 태그이름 저장
    var currentElement:String = ""
    //xml 탐색 시 카테고리 조건에 맞는 과목을 임시로 저장
    var tempSubject = Subject()
    
    var parser = XMLParser()
    //최초 탐색인지 아닌지
    var isInit:Bool = false
    //xml탐색 시 과목에 해당하는 대학, 전공, 학년 저장
    var passedCollegeName:String?
    var passedMajorName:String?
    var passedGrade:String?
    
    //탐색 카테고리에 해당하는 대학, 전공, 학년 저장
    var selectedCollege:String?
    var selectedMajor:String?
    var seletedGrade:String?
    
    //선택된 대학, 전공, 학년이 바뀌었는지 저장
    var collegeChanged:Bool = false
    var majorChanged:Bool = false
    var gradeChanged:Bool = false
    
    //var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //대학 목록 초기화
        isInit = true
        parsingXMLData()
        isInit = false
        
        //대학 목록 중 첫번째 대학을 선택
        ChangeCollege(collegeName: category.college[0])
        
        self.majorPicker.delegate = self
        self.majorPicker.dataSource = self

        /*refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "모르겠어")
        refresher.addTarget(ChoiceTableViewController.self, action: #selector(ChoiceTableViewController.refresh), for: UIControlEvents.valueChanged)*/
        
        
        
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
            ChangeCollege(collegeName: category.college[row])
            self.majorPicker.selectRow(0, inComponent: 1, animated: true)
            self.majorPicker.selectRow(0, inComponent: 2, animated: true)
            
        case 1: ChangeMajor(majorName: category.major[row])
            self.majorPicker.selectRow(0, inComponent: 2, animated: true)
            
        case 2: ChangeGrade(grade: category.grade[row])
            
            
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
    
    func ChangeCollege(collegeName:String) {
        category.major = []
        collegeChanged = true
        selectedCollege = collegeName
        parsingXMLData()
        collegeChanged = false
        ChangeMajor(majorName: category.major[0])
    }
    
    func ChangeMajor(majorName:String) {
        category.grade = []
        majorChanged = true
        selectedMajor = majorName
        parsingXMLData()
        majorChanged = false
        ChangeGrade(grade: category.grade[0])
    }
    
    func ChangeGrade(grade:String) {
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
        //처음 카테고리가 만들어질 때 대학 목록을 저장
        if (isInit && currentElement == "NameOfCollege" && category.college.contains(string) == false) {
            category.college.append(string)
            return
        }
        
        if (currentElement == "NameOfCollege") { passedCollegeName = string }
            
        else if (currentElement == "NameOfMajor") {
            let tempMajorSplit = string.components(separatedBy: "(")[0]
            passedMajorName = tempMajorSplit
            if (collegeChanged && passedCollegeName == selectedCollege && category.major.contains(tempMajorSplit) == false) { category.major.append(tempMajorSplit) }
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
                tempSubject.time = string.components(separatedBy: ",")
            case "Place":
                let tempPlace = string.components(separatedBy: ",")
                for place in tempPlace {
                    tempSubject.place.append(changeBuildingNumberToName(buildingNumber: place))
                }
            case "Professor":
                tempSubject.grade = passedGrade!
                tempSubject.professor = string.components(separatedBy: ",")
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
