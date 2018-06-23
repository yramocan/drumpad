//
//  DrumPadCellOptionsViewModel.swift
//  drumpad
//
//  Created by Yuri Ramocan on 6/23/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import AudioKit
import Foundation

final class DrumPadCellOptionsViewModel {
    private let sampler = AudioSampler.shared
    
    var cellIndex: Int?
    
    func didLoadCellOptions(with index: Int, completion: (_ volume: Double) -> Void) {
        let playerVolume = sampler.getVolume(forIndex: index)
        completion(playerVolume)
    }
    
    func didChangeVolumeSlider(_ volume: Double) {
        guard let index = cellIndex else { return }
        sampler.set(volume: volume, forIndex: index)
    }
}
