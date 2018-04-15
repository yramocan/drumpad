//
//  DrumPadViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

class DrumPadViewModel {
    var kNumberOfDrumPads = 16
    let sampler = AudioSampler()
    
    func playAudioFromSampler(withIndex index: Int) {
        sampler.playSample(at: index)
    }
}
