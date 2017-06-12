//
//  CurriculaTable.swift
//  CurriculaTable
//
//  Created by Sun Yaozhu on 2016-09-10.
//  Copyright © 2016 Sun Yaozhu. All rights reserved.
//

import UIKit

public class CurriculaTable: UIView {
    
    private let controller = CurriculaTableController()
    private let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var mMarginHeight:CGFloat = 0
    private var mMarginWidth:CGFloat = 0
    private var mMarginX:CGFloat = 0
    private var mMarginY:CGFloat = 0
    private var mBoundHeight:CGFloat = 0
    private var mBoundWidth:CGFloat = 0
    private var mShowPlace = true
    
    public var weekdaySymbolType = CurriculaTableWeekdaySymbolType.short {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var firstWeekday = CurriculaTableWeekday.monday {
        didSet {
            collectionView.reloadData()
            drawCurricula()
        }
    }
    
    public var numberOfPeriods = 24 { //nayong 13
        didSet {
            collectionView.reloadData()
            drawCurricula()
        }
    }
    
    //CurriculaTableItem
    public var curricula = [CurriculaTableItem]() {
        didSet {
            drawCurricula()
        }
    }
    
    public var bgColor = UIColor.clear {
        didSet {
            collectionView.backgroundColor = bgColor
        }
    }
    
    public var symbolsBgColor = UIColor.clear {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var symbolsFontSize = CGFloat(14) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var heightOfWeekdaySymbols = CGFloat(28) {
        didSet {
            collectionView.reloadData()
            drawCurricula()
        }
    }
    
    public var widthOfPeriodSymbols = CGFloat(32) {
        didSet {
            collectionView.reloadData()
            drawCurricula()
        }
    }
    
    public var borderWidth = CGFloat(0) {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var borderColor = UIColor.clear {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public var cornerRadius = CGFloat(0) {
        didSet {
            drawCurricula()
        }
    }
    
    public var rectEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            drawCurricula()
        }
    }
    
    public var textEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) {
        didSet {
            drawCurricula()
        }
    }
    
    public var textFontSize = CGFloat(11) {
        didSet {
            drawCurricula()
        }
    }
    
    public var textAlignment = NSTextAlignment.left {
        didSet {
            drawCurricula()
        }
    }
    
    public var maximumNameLength = 0 {
        didSet {
            drawCurricula()
        }
    }
    
    var weekdaySymbols: [String] {
        var weekdaySymbols = [String]()
        
        switch weekdaySymbolType {
        case .normal:
            weekdaySymbols = Calendar.current.standaloneWeekdaySymbols
        case .short:
            weekdaySymbols = Calendar.current.shortStandaloneWeekdaySymbols
        case .veryShort:
            weekdaySymbols = Calendar.current.veryShortStandaloneWeekdaySymbols
        }
        let firstWeekdayIndex = firstWeekday.rawValue - 1
        weekdaySymbols.rotate(shiftingToStart: firstWeekdayIndex)
        
        return weekdaySymbols
    }
    
    public var marginHeight = CGFloat(0) {
        didSet {
            mMarginHeight = marginHeight
        }
    }
    
    public var marginWidth = CGFloat(0) {
        didSet {
            mMarginWidth = marginWidth
        }
    }
    
    public var marginX = CGFloat(0) {
        didSet {
            mMarginX = marginX
        }
    }
    
    public var marginY = CGFloat(0) {
        didSet {
            mMarginY = marginY
        }
    }
    
    public var boundHeight = CGFloat(0) {
        didSet {
            mBoundHeight = boundHeight
        }
    }
    
    public var boundWidth = CGFloat(0) {
        didSet {
            mBoundWidth = boundWidth
        }
    }
    
    //nayong
    public var showPlace = true{
        didSet{
            mShowPlace = showPlace
        }
    }

    var averageHeight: CGFloat {
        //nayong change hieght : height - n
        return (collectionView.frame.height - heightOfWeekdaySymbols - mMarginHeight) / CGFloat(numberOfPeriods)
    }
    var averageWidth: CGFloat {
        return (collectionView.frame.width - widthOfPeriodSymbols - mMarginWidth) / 6
        //nayong : 7 -> 6
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        controller.curriculaTable = self
        controller.collectionView = collectionView
//        controller.collectionView.frame = CGRect.init(x: 0, y: 50, width: collectionView.frame.width, height: collectionView.frame.height)
        controller.collectionView.isScrollEnabled = false //nayong
        collectionView.dataSource = controller
        collectionView.delegate = controller
        collectionView.backgroundColor = bgColor
        addSubview(collectionView)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
//        collectionView.frame = bounds
        var mBounds = CGRect(x:bounds.minX, y:bounds.minY, width: bounds.width - mBoundWidth, height: bounds.height - mBoundHeight)
        collectionView.frame = mBounds
        drawCurricula()
    }
    
    private func drawCurricula() {
        
        print("\(1)")
        
        for subview in subviews {
            if !(subview is UICollectionView) {
                subview.removeFromSuperview()
            }
        }
        
        
        for (index, curriculum) in curricula.enumerated() {
            
            let weekdayIndex = (curriculum.weekday.rawValue - firstWeekday.rawValue + 6) % 6
            //nayong : where to draw the content
            let x = widthOfPeriodSymbols + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left - mMarginX //nayong
            let y = heightOfWeekdaySymbols + averageHeight * CGFloat(curriculum.startPeriod - 1) + rectEdgeInsets.top - marginY//nayong
            let width = averageWidth - rectEdgeInsets.left - rectEdgeInsets.right
            let height = averageHeight * CGFloat(curriculum.endPeriod - curriculum.startPeriod + 1) - rectEdgeInsets.top - rectEdgeInsets.bottom
            
            
            let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            view.backgroundColor = curriculum.bgColor
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
            
            let label = UILabel(frame: CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.left - textEdgeInsets.right, height: view.frame.height - textEdgeInsets.top - textEdgeInsets.bottom))
            var name = curriculum.name
            if maximumNameLength > 0 {
                name.truncate(maximumNameLength)
            }
            
            //setting space
            var stringSpace = ""
            if(name.characters.count>10){
                stringSpace = "\n"
            }
            
            let attrStr = NSMutableAttributedString(string: name + "\n" + stringSpace, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: textFontSize)])
            attrStr.setAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(0..<name.characters.count))
            
            
            print("\(curriculum.name) 3")

            
            label.attributedText = attrStr
            label.textColor = curriculum.textColor
            label.textAlignment = textAlignment
            label.numberOfLines = 0
            label.tag = index
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(curriculumTapped)))
            label.isUserInteractionEnabled = true
            
            
            view.addSubview(label)
            
            var placeStringSpace = ""
            if(curriculum.place.characters.count>5){
                placeStringSpace = "\n"
            }
            
            if(mShowPlace == true){
                
                let label1 = UILabel(frame: CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.left - textEdgeInsets.right, height: view.frame.height - textEdgeInsets.top - textEdgeInsets.bottom))
                let attrStr1 = NSMutableAttributedString(string: stringSpace+placeStringSpace+"\n\n"+curriculum.place, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: textFontSize - CGFloat(2))])
                let countString = curriculum.place.characters.count + 2
                attrStr1.setAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: textFontSize - CGFloat(2))], range: NSRange(0..<countString))
                
                
                label1.attributedText = attrStr1
                label1.textColor = curriculum.textColor
                label1.textAlignment = textAlignment
                label1.numberOfLines = 0
                //label1.tag = index + 1000 //???nayong
                
                print("\(curriculum.name) add subView 1")
            view.addSubview(label1)
                print("\(curriculum.name) add subView 2")
            }
            
            
            print("\(curriculum.name) 5")

            
            addSubview(view)
            

            
//            let label = UILabel(frame: CGRect(x: textEdgeInsets.left, y: textEdgeInsets.top, width: view.frame.width - textEdgeInsets.left - textEdgeInsets.right, height: view.frame.height - textEdgeInsets.top - textEdgeInsets.bottom))
//            var name = curriculum.name
//            if maximumNameLength > 0 {
//                name.truncate(maximumNameLength)
//            }
//            
//            let attrStr = NSMutableAttributedString(string: name + "\n\n" + curriculum.place, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: textFontSize)])
//            attrStr.setAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: textFontSize)], range: NSRange(0..<name.characters.count))
//            
//            label.attributedText = attrStr
//            label.textColor = curriculum.textColor
//            label.textAlignment = textAlignment
//            label.numberOfLines = 0
//            label.tag = index
//            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(curriculumTapped)))
//            label.isUserInteractionEnabled = true
//            
//            view.addSubview(label)
//            addSubview(view)
            
            
        }
    }
    
    func curriculumTapped(_ sender: UITapGestureRecognizer) {
//        let curriculum = curricula[(sender.view as! UILabel).tag]
//        curriculum.tapHandler(curriculum)

    }
    
}
