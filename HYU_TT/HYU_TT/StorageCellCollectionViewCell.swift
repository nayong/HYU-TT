//
//  StorageCellCollectionViewCell.swift
//  HYU_TT
//
//  Created by 김나용 on 2017. 6. 10..
//  Copyright © 2017년 김나용. All rights reserved.
//

import UIKit
import Foundation
import CurriculaTable

class StorageCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var curriculaTable: CurriculaTable!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var creditLabel: UILabel!
    
}
