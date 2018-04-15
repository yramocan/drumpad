//
//  DrumPadViewController+UICollectionView.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

extension DrumPadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.kNumberOfDrumPads
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = drumPadCollectionView.dequeueReusableCell(withReuseIdentifier: "DrumPadCell", for: indexPath) as! DrumPadCollectionViewCell
        return cell
    }
}

extension DrumPadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = drumPadCollectionView.cellForItem(at: indexPath) as? DrumPadCollectionViewCell else { return }
        cell.backgroundColor = cell.activeColor
        
        triggerSample(with: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = drumPadCollectionView.cellForItem(at: indexPath) as? DrumPadCollectionViewCell else { return }
        cell.backgroundColor = cell.inactiveColor
    }
}
