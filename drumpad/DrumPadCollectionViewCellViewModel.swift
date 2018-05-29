//
//  DrumPadCollectionViewCellViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/18/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import Foundation

class DrumPadCollectionViewCellViewModel {
    // Perhaps there's a better way to do this.
    var sampler: AudioSampler?
    var volume: Double = 1.0
    
    func playAudioFromSampler(withCell cell: DrumPadCollectionViewCell) {
        guard let audioSampler = sampler else {
            print("Audio sampler not set. Cancelling playback.")
            return
        }
        
        audioSampler.playSample(withCell: cell)
    }
}
