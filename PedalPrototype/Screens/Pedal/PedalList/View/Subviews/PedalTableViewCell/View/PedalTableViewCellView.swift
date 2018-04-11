//
//  PedalTableViewCellView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalTableViewCellView: UITableViewCell {
    
    @IBOutlet weak var pedalName: UILabel!
    @IBOutlet weak var roundView: RoundShadowView!
    
    var viewModel: PedalTableViewCellViewModelProtocol? {
        didSet {
            self.pedalName.text = self.viewModel?.getPedalName()
            self.setKnobPositions()
        }
    }
    
    func setKnobPositions() {
        
        guard let knobs = self.viewModel?.getKnobs() else {
            return
        }
        
        var i = 1
        
        for (knob, value) in knobs {
            let knobView = KnobSlider(frame: CGRect(x: 30 * i,
                                                    y: 58,
                                                    width: 30,
                                                    height: 30))
            
            let labelRect = CGRect(x: 30 * i, y: 88, width: 45, height: 10)
            let nameLabel = UILabel(frame: labelRect)
            nameLabel.center.x = knobView.center.x
            nameLabel.textColor = UIColor.silverSand
            nameLabel.text = knob
            nameLabel.font = UIFont(name: "Futura", size: 8)
            nameLabel.textAlignment = .center
            
            i = i+2
            
            self.roundView.addSubview(knobView)
            self.roundView.addSubview(nameLabel)
        }
    }
}
