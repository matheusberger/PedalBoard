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
            let knobView = KnobView(withTitle: viewmodel.getKnobName(), andPercentage: viewmodel.getPercentage())
            
            self.addSubview(knobView)
        }
    }
}
