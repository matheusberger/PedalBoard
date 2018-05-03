//
//  PercentageKnobSlider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 19/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PercentageKnobSlider: KnobSlider {
    
    var percentageLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(withTitle title: String, andValue value: Int, withFrame frame: CGRect) {
        super.init(withTitle: title, andValue: value, withFrame: frame)
        
        let labelRect = CGRect(x: 0, y: -12, width: 45, height: 10)
        self.percentageLabel = UILabel(frame: labelRect)
        self.percentageLabel.text = String(value) + "%"
        self.percentageLabel.textAlignment = .center
        self.percentageLabel.center.x = self.center.x
        
        self.percentageLabel.font = UIFont(name: "Futura", size: 6)
        self.percentageLabel.textColor = UIColor.hanPurple
    }
}
