//
//  AudioSampler.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/4/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import Foundation
import AudioKit

class AudioSampler {
    var samples = ["kick.wav", "hi_hat.wav", "open_hat.wav", "clap.wav", "snare_1.wav", "snare_2.wav", "808_g.wav", "808_e.wav", "bamboo.wav", "shuffle.wav", "tambourine.wav", "rhodes_sample.wav", "guitar_sample_1.wav", "guitar_sample_2.wav", "guitar_sample_3.wav", "guitar_sample_4.wav"]
    
    func playSample(at index: Int) {
        guard let audioFile = try? AKAudioFile(readFileName: samples[index]) else { print("File Error."); return }
        
        let player = AKPlayer(audioFile: audioFile)
        player.completionHandler = {
            print("\nDrumpad Logger: Played \(audioFile.fileName).\(audioFile.fileExt).")
        }
        
        AudioKit.output = player

        do {
            try AudioKit.start()
            (player.isPlaying) ? player.stop() : player.play()
        } catch let error {
            print("ERROR: \(error)")
        }
    }
}
