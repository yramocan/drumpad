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
    
    var filename: String? {
        guard let index = cellIndex,
              let player = sampler.player(at: index),
              let name = player.audioFile?.fileName,
              let ext = player.audioFile?.fileExt else { return nil }
        
        return "\(name).\(ext)"
    }
    
    var isRecording: Bool {
        return sampler.recorder.isRecording
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
        guard !isRecording else {
            stopRecording()
            return
        }
        
        do {
            try sampler.recorder.reset()
            try sampler.recorder.record()
            
            NotificationCenter.default.post(name: .didToggleRecording, object: isRecording)
            
        } catch let error {
            AKLog("Error: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        guard isRecording else {
            startRecording()
            return
        }
        
        sampler.recorder.stop()
        
        NotificationCenter.default.post(name: .didToggleRecording, object: isRecording)
        
        guard let index = cellIndex,
              let audioFile = sampler.recorder.audioFile else { return }
        
        sampler.setSample(for: index, audioFile: audioFile)
    }
}
