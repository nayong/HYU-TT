//
//  TodayViewController.swift
//  WidgetTest
//
//  Created by 김나용 on 2017. 6. 8..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    let mSize:CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load big view with custom height
        //self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.compact
        //load small view which can change the height -> func widgetActiveDisplayModeDidChange
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        //clockUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if(activeDisplayMode == NCWidgetDisplayMode.compact){
            self.preferredContentSize = maxSize
        }else{
            self.preferredContentSize = CGSize(width: maxSize.width, height: mSize)
        }
    }
    

//    func clockUpdate(){
//        let currentTime = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .full, timeStyle: .full)
//        MyTextField.text = currentTime
//    }
    




}
