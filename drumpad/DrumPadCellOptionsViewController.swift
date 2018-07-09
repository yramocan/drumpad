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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var volumeValueLabel: UILabel!
    @IBOutlet weak var volumeSlider: UISlider!
    
    private let viewModel = DrumPadCellOptionsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObservers()
        setUpTableView()
        
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
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
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
        print("Reset!")
        
        viewModel.resetAudioSample()
    }
}

// MARK: UITableViewDataSource
extension DrumPadCellOptionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AudioSampler.samples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "audioSampleCell", for: indexPath) as! AudioSampleTableViewCell
        
        cell.sampleNameLabel.text = AudioSampler.samples[indexPath.row]
        
        print("cell text: \(cell.sampleNameLabel.text!) | filename: \(viewModel.filename!)")
        
        if cell.sampleNameLabel.text == viewModel.filename {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
}

// MARK: UITableViewDelegate
extension DrumPadCellOptionsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}
