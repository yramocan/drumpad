//
//  DrumPadCellOptionsViewController.swift
//  drumpad
//
//  Created by Yuri Ramocan on 5/28/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadCellOptionsViewController: UIViewController {
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    private let viewModel = DrumPadCellOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObservers()
        
        viewModel.didLoadCellOptions() { [weak self] (volume) in
            self?.volumeSlider.value = Float(volume)
            self?.volumeValueLabel.text = "\(Int(volume * 100))"
        }
    }
    
    func setCellIndex(_ index: Int) {
        viewModel.cellIndex = index
    }
    
    private func setUpObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleRecordButton),
                                               name: .didToggleRecording, object: nil)
    }
    
    @objc private func toggleRecordButton(_ notification: Notification) {
        guard let isRecording = notification.object as? Bool else { return }
        
        let buttonText = isRecording ? "Stop" : "Record"
        recordButton.setTitle(buttonText, for: .normal)
    }
}

// MARK: - Extensions

// MARK: IBActions
extension DrumPadCellOptionsViewController {
    @IBAction func volumeSliderChanged(_ sender: Any) {
        let volumeSliderValue = Double(volumeSlider.value)
        viewModel.didChangeVolumeSlider(volumeSliderValue)
        volumeValueLabel.text = "\(Int(volumeSliderValue * 100))"
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        if viewModel.isRecording {
            viewModel.stopRecording()
        } else {
            viewModel.startRecording()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        viewModel.resetAudioSample()
    }
}
