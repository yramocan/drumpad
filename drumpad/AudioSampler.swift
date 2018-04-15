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
    var samples = ["kick.wav", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen"]
    
    func playSample(at index: Int) {
        guard let audioFile = try? AKAudioFile(readFileName: samples[index]) else { print("File Error."); return }
        
        let player = AKPlayer(audioFile: audioFile)
        player.completionHandler = {
            print("\nDrumpad Logger: Played \(audioFile.fileName).\(audioFile.fileExt).")
        }
        
        AudioKit.output = player

        do {
            try AudioKit.start()
            player.play()
        } catch let error {
            print("ERROR: \(error)")
        }
    }
}
