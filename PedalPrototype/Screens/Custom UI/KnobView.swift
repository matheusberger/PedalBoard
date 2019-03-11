//
//  KnobView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 11/03/19.
//  Copyright © 2019 mcb3. All rights reserved.
//

import UIKit

class KnobView: UIView {
    var knobSlider: KnobSlider!
    var titleLabel: UILabel!
    var percentageLabel: UILabel!
    
    init(withTitle title: String, andPercentage percentage: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 26, height: 46))
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 36, width: 26, height: 10))
        titleLabel.text = title
        
        percentageLabel = UILabel(frame: CGRect(x: 3, y: 0, width: 13, height: 8))
        
        percentageLabel.text = "\(percentage)%"
        self.setupSlider()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 26, height: 20))
        self.setupSlider()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSlider()
    }
    
    func setupSlider() {
        knobSlider = KnobSlider(atPosition: CGPoint(x: 0, y: 0))
        knobSlider.value
        self.addSubview(knobSlider)
    }
}
