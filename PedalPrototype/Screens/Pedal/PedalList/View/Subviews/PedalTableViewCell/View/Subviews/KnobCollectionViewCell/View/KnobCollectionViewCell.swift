//
//  KnobCollectionViewCell.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class KnobCollectionViewCell: UICollectionViewCell {
    
    var viewmodel: KnobCollectionViewCellProtocol! {
        didSet {
            let knobview = KnobSlider(withTitle: self.viewmodel.getKnobName(), andValue: self.viewmodel.getPercentage(), withFrame: self.bounds)
            self.addSubview(knobview)
        }
    }
}
