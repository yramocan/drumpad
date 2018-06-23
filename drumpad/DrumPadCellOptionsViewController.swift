//
//  DrumPadCellOptionsViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 5/28/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadCellOptionsViewController: UIViewController {
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    private let viewModel = DrumPadCellOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.didLoadCellOptions(with: 0) { (volume) in
            self.volumeSlider.value = Float(volume)
            self.volumeLabel.text = "Cell Volume: \(Int(volume * 100))"
        }
    }
    
    func setCellIndex(_ index: Int) {
        viewModel.cellIndex = index
    }
    
    @IBAction func volumeSliderChanged(_ sender: Any) {
        let volumeSliderValue = Double(volumeSlider.value)
        viewModel.didChangeVolumeSlider(volumeSliderValue)
        volumeLabel.text = "Cell Volume: \(Int(volumeSliderValue * 100))"
        
//        cell.viewModel.volume = Double(volumeSlider.value)
    }
}
