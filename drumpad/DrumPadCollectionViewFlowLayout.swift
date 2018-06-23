//
//  DrumPadCollectionViewFlowLayout.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/15/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadCollectionViewFlowLayout: UICollectionViewFlowLayout {
    let kNumberOfColumns: CGFloat = 4
    let kGutterSpacing: CGFloat = 10
    
    override var itemSize: CGSize {
        set {}
        get {
            // TODO: Figure this out.
            guard let collectionView = self.collectionView else { return CGSize(width: 175, height: 175) }
            let itemWidth = (collectionView.frame.width - ((kNumberOfColumns * kGutterSpacing) - kGutterSpacing)) / kNumberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    override init() {
        super.init()
        setUpLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpLayout()
    }
    
    func setUpLayout() {
        minimumInteritemSpacing = kGutterSpacing
        minimumLineSpacing = kGutterSpacing
        scrollDirection = .vertical
    }
}
