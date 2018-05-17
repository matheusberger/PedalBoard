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
            let origin = CGPoint(x: 0, y: 0)
            let knobView = KnobSlider(withTitle: self.viewmodel.getKnobName(), andValue: self.viewmodel.getPercentage(), atPosition: origin)
            
            self.addSubview(knobView)
        }
    }
}
