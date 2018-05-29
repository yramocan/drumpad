//
//  DrumPadCollectionViewCellViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 5/28/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadCollectionViewCellViewController: UIViewController {
    @IBOutlet weak var optionsLabel: UILabel!
    
    var cell: DrumPadCollectionViewCell?
    @IBOutlet weak var volumeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cell = cell else { return }
        volumeSlider.value = Float(cell.viewModel.volume)
        optionsLabel.text = "Cell Volume: \(Int(cell.viewModel.volume * 100))"
    }
    
    @IBAction func volumeSliderChanged(_ sender: Any) {
        guard let cell = cell else { return }
        cell.viewModel.volume = Double(volumeSlider.value)
        optionsLabel.text = "Cell Volume: \(Int(cell.viewModel.volume * 100))"
    }
}
