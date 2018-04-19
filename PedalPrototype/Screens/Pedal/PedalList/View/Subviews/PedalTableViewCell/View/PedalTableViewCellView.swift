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
    @IBOutlet weak var knobBaseView: UIView!
    
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
        
        if knobs.keys.count > 5 {
            self.roundView.frame.size.height = self.roundView.frame.size.height + 46
        }
        
        var i = 0
        var j = 0
        
        for (knob, value) in knobs {
            let knobView = KnobSlider(withTitle: knob,
                                      andValue: value,
                                      withFrame: CGRect(x: 50 * i, y: j * 50 , width: 20, height: 30))
            
            i = i + 1
            if i == 5 {
                i = 0
                j = j + 1
            }
            
            self.knobBaseView.addSubview(knobView)
        }
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.viewModel?.edit()
    }
}
