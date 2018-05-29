//
//  DrumPadViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 3/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit
import AudioKit

class DrumPadViewController: UIViewController {
    @IBOutlet weak var drumPadCollectionView: UICollectionView!
    
    let viewModel = DrumPadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }

    func setUpCollectionView() {
        drumPadCollectionView.collectionViewLayout = DrumPadCollectionViewFlowLayout()
        drumPadCollectionView.delaysContentTouches = false
        drumPadCollectionView.allowsMultipleSelection = true
        drumPadCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellOptionsSegue" {
            guard let destinationVC = segue.destination as? DrumPadCollectionViewCellViewController else { return }
            guard let cell = sender as? DrumPadCollectionViewCell else { return }
            
            destinationVC.cell = cell
        }
    }
}

extension DrumPadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDrumPads
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = drumPadCollectionView.dequeueReusableCell(withReuseIdentifier: "DrumPadCell", for: indexPath) as! DrumPadCollectionViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.viewModel.sampler = viewModel.sampler
        
        return cell
    }
}

extension DrumPadViewController: DrumPadCollectionViewCellDelegate {
    func presentCellOptionsView(_ cell: DrumPadCollectionViewCell) {
        self.performSegue(withIdentifier: "cellOptionsSegue", sender: cell)
    }
}
