//
//  DrumPadCollectionViewCell.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/14/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadCollectionViewCell: UICollectionViewCell {    
    let activeColor: UIColor = UIColor.Drumpad.bloodOrange
    let inactiveColor: UIColor = UIColor.Drumpad.lightOrange

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = inactiveColor
    }
}
