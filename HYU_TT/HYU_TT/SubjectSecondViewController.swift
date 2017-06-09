//
//  SubjectSecondViewController.swift
//  HYU_TT
//
//  Created by 김영호 on 2017. 6. 1..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit

class SubjectSecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, XMLParserDelegate, BEMCheckBoxDelegate {

    var parser = XMLParser()
    var category:[String] = []
    var selectedCategory = ""
    var passedCategory = ""
    var isBoxChecked:[Bool] = [false, false, false, false, false, false]

    var isInit:Bool = true
    


    var tempSubject = Subject()
    var currentElement:String = ""
    var isPlaceSplited = false
    var splitedPlace = ""

    @IBOutlet weak var mondayCheckBox: BEMCheckBox!
    @IBOutlet weak var tuesCheckBox: BEMCheckBox!
    @IBOutlet weak var wenCheckBox: BEMCheckBox!
    @IBOutlet weak var thurCheckBox: BEMCheckBox!
    @IBOutlet weak var friCheckBox: BEMCheckBox!
    @IBOutlet weak var satCheckBox: BEMCheckBox!
    
    @IBOutlet weak var liberalPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        parsingXMLData()
        isInit = false
        if (category.count <= 0) { return }
        selectedCategory = category[0]
        parsingXMLData()
        MySubjects.isChanged = true
        
        self.liberalPicker.delegate = self
        self.liberalPicker.dataSource = self
        self.mondayCheckBox.delegate = self
        self.tuesCheckBox.delegate = self
        self.wenCheckBox.delegate = self
        self.thurCheckBox.delegate = self
        self.friCheckBox.delegate = self
        self.satCheckBox.delegate = self //initialize
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        isBoxChecked[checkBox.tag] = checkBox.on
        parsingXMLData()
        MySubjects.isChanged = true
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
        parsingXMLData()
        MySubjects.isChanged = true
    }
    
    func parsingXMLData() {
        
        guard let file = Bundle.main.path(forResource: "liberal", ofType: "xml") else {
            print("cannot find file!")
            return
        }
        MySubjects.subjects = []
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
    
    func dayToInt(day:String)->Int {
        switch day {
        case "월":
            return 0
        case "화":
            return 1
        case "수":
            return 2
        case "목":
            return 3
        case "금":
            return 4
        case "토":
            return 5
        default:
            return -1
        }
    }
    
    func isTimeInSelectedDay(times:[String]) -> Bool {
        for time in times {
            let dayIndex = dayToInt(day: time.substring(with: 0..<1))
            if (dayIndex == -1) { return false }
            
            if (isBoxChecked[dayIndex]) {
                return true
            }
        }
        return false
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //    if (currentElement == "NameOfCollege") { print (1) }
        if (isInit && currentElement == "nameOfLiberalArt" && category.contains(string) == false) {
//            print (string)
            category.append(string)
            return
        }

        if (currentElement == "nameOfLiberalArt") {
            passedCategory = string
        }
        if (selectedCategory == passedCategory) {
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
                if (isPlaceSplited) {
                    splitedPlace += string
                    tempSubject.place.append(splitedPlace)
                    splitedPlace = ""
                    isPlaceSplited = false
                }
                else {
                    if (string.characters.count == 4) {
                        splitedPlace = changeBuildingNumberToName(buildingNumber: string)
                        isPlaceSplited = true
                    }
                    else {
                        tempSubject.place = []
                        let tempPlace = string.components(separatedBy: ",")
                        for place in tempPlace {
                            tempSubject.place.append(changeBuildingNumberToName(buildingNumber: place))
                        }
                        
                    }
                }
            case "Professor":
                if (isTimeInSelectedDay(times: tempSubject.time)) {
                    tempSubject.professor = string.components(separatedBy: ",")
                    MySubjects.subjects.append(tempSubject)
                }
                tempSubject = Subject()
            default: return
            }
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
