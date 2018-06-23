//
//  AudioSampler.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/4/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import Foundation
import AudioKit

final class AudioSampler {
    static let shared = AudioSampler()
    
    private let samples = ["kick.wav", "hi_hat.wav", "open_hat.wav", "clap.wav", "snare_1.wav", "snare_2.wav", "808_g.wav", "808_e.wav", "bamboo.wav", "shuffle.wav", "tambourine.wav", "rhodes_sample.wav", "guitar_sample_1.wav", "guitar_sample_2.wav", "guitar_sample_3.wav", "guitar_sample_4.wav"]
    
    private var mixer: AKMixer?
    private var nodes = [AKNode]()
    
    func createPlayer(withIndex index: Int) {
        guard let audioFile = try? AKAudioFile(readFileName: samples[index]) else {
            print("File Error.")
            return
        }
        
        let player = AKPlayer(audioFile: audioFile)
        player.completionHandler = {
            print("\nDrumpad Logger: Played \(audioFile.fileName).\(audioFile.fileExt) at volume \(player.volume).")
        }
        
        nodes.append(player)
    }
    
    func configureAudioEngine() {
        mixer = AKMixer(nodes)
        AudioKit.output = mixer
        
        do {
            try AudioKit.start()
        } catch let error {
            print("ERROR: \(error.localizedDescription)")
        }
    }
    
    func playSample(with index: Int) {
        guard let player = nodes[index] as? AKPlayer else { return }
        
        player.fade.inTime = 0.01
        player.fade.outTime = 0.1
        
        if player.isPlaying { player.pause() }
        player.play()
    }
    
    func getVolume(forIndex index: Int) -> Double {
        guard let player = nodes[index] as? AKPlayer else { return -1 }
        return player.volume
    }
    
    func set(volume: Double, forIndex index: Int) {
        guard let player = nodes[index] as? AKPlayer else { return }
        player.volume = volume
    }
}
