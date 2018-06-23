//
//  DrumPadViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/13/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import AudioKit
import Foundation

final class DrumPadViewModel {
    let numberOfDrumPads = 16
    let sampler = AudioSampler.shared
    
    func drumPadDidAppear() {
        sampler.configureAudioEngine()
    }
    
    func createPlayerNode(with index: Int) {
        sampler.createPlayer(withIndex: index)
    }
}
