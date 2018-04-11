//
//  KnobSlider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 11/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit
import MSCircularSlider

class KnobSlider: UIView {
    
    var slider: MSCircularSlider!
    var knobImageView: UIImageView!
    var titleLabel: UILabel!
    
    var value: Int!
    
    fileprivate var knobTransform: CGAffineTransform!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    init(withTitle title: String, andValue value: Int, withFrame frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
        
        let labelRect = CGRect(x: 0, y: 32, width: 45, height: 10)
        self.titleLabel = UILabel(frame: labelRect)
        self.titleLabel.center.x = self.slider.center.x
        self.titleLabel.textColor = UIColor.silverSand
        self.titleLabel.text = title
        self.titleLabel.font = UIFont(name: "Futura", size: 8)
        self.titleLabel.textAlignment = .center
        
        self.addSubview(self.titleLabel)
        self.slider._currentValue = Double(value)
    }
    
    func setupView() {
        self.value = 0
        self.frame.size = CGSize(width: 30, height: 30)
        
        self.slider = MSCircularSlider()
        self.slider.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.slider._filledColor = UIColor.hanPurple
        self.slider.unfilledColor = UIColor.silverSand
        self.slider.handleType = .smallCircle
        self.slider.handleColor = UIColor.hanPurple
        self.slider.lineWidth = 1
        self.slider.rotationAngle = -90
        self.slider._maximumAngle = 270
        self.slider.minimumValue = 0
        self.slider.maximumValue = 100
        self.slider.currentValue = 0
        
        self.slider.delegate = self
        
        self.knobImageView = UIImageView(image: UIImage.init(named: "knob_icon"))
        self.knobImageView.frame.size = CGSize(width: 18, height: 18)
        self.knobImageView.center = self.slider.center
        
        self.knobTransform = self.knobImageView.transform
        
        self.addSubview(knobImageView)
        self.addSubview(self.slider)
    }

}

extension KnobSlider: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.knobImageView.transform = self.knobTransform.rotated(by: CGFloat(value/22))
        self.value = Int(value)
    }
    
    func circularSlider(_ slider: MSCircularSlider, startedTrackingWith value: Double) {
        //animate begin
    }
    
    func circularSlider(_ slider: MSCircularSlider, endedTrackingWith value: Double) {
        //animate end
    }
    
    
}
