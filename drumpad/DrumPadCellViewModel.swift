//
//  DrumPadCellViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/18/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import Foundation

final class DrumPadCellViewModel {
    private let sampler = AudioSampler.shared
    
    func playSample(with index: Int) {
        sampler.playSample(with: index)
    }
}
