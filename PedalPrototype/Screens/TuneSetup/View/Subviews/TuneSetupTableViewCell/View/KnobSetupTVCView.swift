//
//  KnobSetupTVCView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class KnobSetupTVCView: UITableViewCell {
    
    @IBOutlet weak var knobValue: UILabel!
    @IBOutlet weak var knobName: UILabel!
    @IBOutlet weak var knobSlider: UISlider!
    
    var value: Float! {
        didSet {
            let intV = Int(value)
            self.knobValue.text = String(intV)
        }
    }
    
    
    var viewModel: KnobSetupTVCViewModelProtocol! {
        didSet {
            self.knobName.text = viewModel.getKnobName()
            self.knobValue.text = String(viewModel.getKnobValue())
            self.knobSlider.setValue(Float(viewModel.getKnobValue()), animated: true)
        }
    }
    
    @IBAction func didChangeValue(_ sender: Any) {
        self.value = self.knobSlider.value
    }
}
