//
//  DrumPadCollectionViewCell.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/14/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit
import AudioKit

protocol DrumPadCollectionViewCellDelegate: class {
    func presentCellOptionsView(_ cell: DrumPadCollectionViewCell)
}

class DrumPadCollectionViewCell: UICollectionViewCell {
    let activeColor: UIColor = UIColor.Drumpad.bloodOrange
    let inactiveColor: UIColor = UIColor.Drumpad.lightOrange
    let viewModel = DrumPadCollectionViewCellViewModel()
    
    weak var delegate: DrumPadCollectionViewCellDelegate?
    
    var state: DrumPadState = .padInactive {
        didSet {
            if (state == .padActive) {
                backgroundColor = activeColor
            } else {
                backgroundColor = inactiveColor
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = inactiveColor
        setUpLongPressGestureRecognizer()
    }
    
    // MARK: Helper Methods
    
    func playSample() {
        viewModel.playAudioFromSampler(withCell: self)
    }
    
    func setUpLongPressGestureRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            delegate?.presentCellOptionsView(self)
        }
    }
    
    // MARK: UIResponder Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        state = .padActive
        playSample()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        state = .padInactive
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        state = .padInactive
    }
}

// MARK: DrumPadCollectionViewCell+DrumPadState

extension DrumPadCollectionViewCell {
    enum DrumPadState {
        case padActive
        case padInactive
    }
}
