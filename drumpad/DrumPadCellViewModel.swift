//
//  DrumPadCellViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/18/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import AudioKit
import Foundation

final class DrumPadCellViewModel {
    var volume: Double = 1.0
    
    private let sampler = AudioSampler.shared
    
    func playSample(with index: Int) {
        sampler.playSample(with: index)
    }
}
