//
//  DrumPadCell.swift
//  drumpad
//
//  Created by Yuri Ramocan on 4/14/18.
//  Copyright © 2018 Yuri Ramocan. All rights reserved.
//

import UIKit

protocol DrumPadCellDelegate: class {
    func presentCellOptionsView(for cell: DrumPadCell)
}

class DrumPadCell: UICollectionViewCell {
    let activeColor: UIColor = UIColor.Drumpad.bloodOrange
    let inactiveColor: UIColor = UIColor.Drumpad.lightOrange
    
    weak var delegate: DrumPadCellDelegate?
    
    var state: DrumPadState = .padInactive {
        didSet {
            if (state == .padActive) {
                backgroundColor = activeColor
            } else {
                backgroundColor = inactiveColor
            }
        }
    }
    
    private let viewModel = DrumPadCellViewModel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = inactiveColor
        setUpLongPressGestureRecognizer()
    }
    
    // MARK: Helper Methods
    
    func setUpLongPressGestureRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longTap(_:))
        )
        
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            delegate?.presentCellOptionsView(for: self)
        }
    }
    
    // MARK: UIResponder Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        state = .padActive
        viewModel.playSample(with: self.tag)
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
extension DrumPadCell {
    enum DrumPadState {
        case padActive
        case padInactive
    }
}
