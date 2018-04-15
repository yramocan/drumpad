//
//  DrumPadViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 3/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadViewController: UIViewController {
    @IBOutlet weak var drumPadCollectionView: UICollectionView!
    
    let viewModel = DrumPadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }

    func setUpCollectionView() {
        drumPadCollectionView.delaysContentTouches = false
        drumPadCollectionView.allowsMultipleSelection = true
        drumPadCollectionView.dataSource = self
        drumPadCollectionView.collectionViewLayout = DrumPadCollectionViewFlowLayout.init()
    }
    
    func triggerSample(with indexPath: IndexPath) {
        viewModel.playAudioFromSampler(withIndex: indexPath.row)
    }
}

