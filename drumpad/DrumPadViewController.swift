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
    
    private var viewModel = DrumPadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.drumPadDidAppear()
    }

    func setUpCollectionView() {
        drumPadCollectionView.collectionViewLayout = DrumPadCollectionViewFlowLayout()
        drumPadCollectionView.delaysContentTouches = false
        drumPadCollectionView.allowsMultipleSelection = true
        drumPadCollectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellOptionsSegue" {
            guard let destinationVC = segue.destination as? DrumPadCellOptionsViewController else { return }
            guard let cell = sender as? DrumPadCell else { return }
            
            destinationVC.setCellIndex(cell.tag)
        }
    }
}

extension DrumPadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDrumPads
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = drumPadCollectionView.dequeueReusableCell(withReuseIdentifier: "DrumPadCell", for: indexPath) as! DrumPadCell
        cell.delegate = self
        cell.tag = indexPath.row
        
        viewModel.createPlayerNode(with: indexPath.row)
        
        return cell
    }
}

extension DrumPadViewController: DrumPadCellDelegate {
    func presentCellOptionsView(for cell: DrumPadCell) {
        self.performSegue(withIdentifier: "cellOptionsSegue", sender: cell)
    }
}
