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
    var percentageLabel: UILabel!
    
    var value: Int!
    
    fileprivate var yOffset: Int = 0
    fileprivate var knobTransform: CGAffineTransform!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    init(withTitle title: String, andValue value: Int, atPosition position: CGPoint, showPercentage: Bool? = false) {
        
        if showPercentage! {
            self.yOffset = 12
        }
        
        let frame = CGRect(x: position.x, y: position.y, width: 20, height: CGFloat(32 + self.yOffset))
        super.init(frame: frame)
        
        self.setupView()
        
        self.titleLabel.text = title
        self.slider._currentValue = Double(value)
    }
    
    func setupView() {
        
        self.value = 0
        
        let percentageRect = CGRect(x: 0, y: 0, width: 20, height: 8)
        self.percentageLabel = UILabel(frame: percentageRect)
        
        if self.yOffset != 0 {
            self.percentageLabel.center.x = self.center.x
            self.percentageLabel.textColor = UIColor.hanPurple
            self.percentageLabel.font = UIFont(name: "Futura", size: 8)
            self.percentageLabel.textAlignment = .center
            
            self.addSubview(self.percentageLabel)
        }
        
        self.slider = MSCircularSlider()
        self.slider.frame = CGRect(x: 0, y: self.yOffset, width: 20, height: 20)
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
        self.knobImageView.frame.size = CGSize(width: 12, height: 12)
        self.knobImageView.center = self.slider.center
        
        self.knobTransform = self.knobImageView.transform
        
        let labelRect = CGRect(x: 0, y: 22 + self.yOffset, width: 45, height: 10)
        self.titleLabel = UILabel(frame: labelRect)
        self.titleLabel.center.x = self.slider.center.x
        self.titleLabel.textColor = UIColor.silverSand
        self.titleLabel.font = UIFont(name: "Futura", size: 8)
        self.titleLabel.textAlignment = .center
        
        self.addSubview(self.knobImageView)
        self.addSubview(self.slider)
        self.addSubview(self.titleLabel)
    }

}

extension KnobSlider: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        self.knobImageView.transform = self.knobTransform.rotated(by: CGFloat(value/22))
        self.value = Int(value)
        self.percentageLabel.text = "\(self.value!)%"
    }
    
    func circularSlider(_ slider: MSCircularSlider, startedTrackingWith value: Double) {
        //animate begin
    }
    
    func circularSlider(_ slider: MSCircularSlider, endedTrackingWith value: Double) {
        //animate end
    }
    
}
