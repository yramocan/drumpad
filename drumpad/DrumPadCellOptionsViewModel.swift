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
    
    var isRecording = false
    
    var filename: String? {
        guard let index = cellIndex,
            let player = sampler.player(at: index) else { return nil }
        return player.audioFile?.fileName
    }
    
    func didLoadCellOptions(completion: (_ volume: Double) -> Void) {
        guard let index = cellIndex else { return }
        let playerVolume = sampler.getVolume(forIndex: index)
        completion(playerVolume)
    }
    
    func didChangeVolumeSlider(_ volume: Double) {
        guard let index = cellIndex else { return }
        sampler.set(volume: volume, forIndex: index)
    }
    
    func resetAudioSample() {
        guard let index = cellIndex else { return }
        sampler.resetSample(for: index)
    }
    
    func startRecording() {
        isRecording = true
    }
    
    func stopRecording() {
        isRecording = false
    }
}
