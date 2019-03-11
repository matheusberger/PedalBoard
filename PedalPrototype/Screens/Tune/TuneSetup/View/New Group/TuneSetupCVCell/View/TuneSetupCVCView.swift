//
//  TuneSetupCVCell.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 20/02/19.
//  Copyright © 2019 mcb3. All rights reserved.
//

import UIKit

class TuneSetupCVCView: UICollectionViewCell {
    
    @IBOutlet weak var pedalNameLabel: UILabel!
    @IBOutlet weak var knobSlider: KnobSlider!
    
    var viewModel: TuneSetupCVCViewModelProtocol! {
        didSet {
            self.pedalNameLabel.text = viewModel.getPedalName()
        }
    }
}
