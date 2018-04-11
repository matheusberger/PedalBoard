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
            let knobView = KnobSlider(withTitle: knob,
                                      andValue: value,
                                      withFrame: CGRect(x: 30 * i, y: 55, width: 30, height: 40))
            
            i = i+2
            
            self.roundView.addSubview(knobView)
        }
    }
}
