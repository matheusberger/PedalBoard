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
    
    var value: Int!
    
    fileprivate var knobTransform: CGAffineTransform!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupView()
    }
    
    init(atPosition position: CGPoint) {
        let frame = CGRect(x: position.x, y: position.y, width: 20, height: 32)
        super.init(frame: frame)
        
        self.setupView()
        self.slider._currentValue = Double(value)
    }
    
    func setupView() {
        
        self.value = 0
        
        self.slider = MSCircularSlider()
        self.slider.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
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
        self.knobTransform = self.knobImageView.transform
        
        self.addSubview(self.knobImageView)
        self.addSubview(self.slider)
        
        self.setConstraints()
    }
    
    func setConstraints() {
        self.slider.translatesAutoresizingMaskIntoConstraints = false
        self.knobImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.slider.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.slider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.slider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.slider.updateConstraints()
        
        self.knobImageView.heightAnchor.constraint(equalToConstant: self.slider.frame.height).isActive = true
        self.knobImageView.widthAnchor.constraint(equalToConstant: self.slider.frame.width * 1.15).isActive = true
        self.knobImageView.centerXAnchor.constraint(equalTo: self.slider.centerXAnchor, constant: 0).isActive = true
        self.knobImageView.centerYAnchor.constraint(equalTo: self.slider.centerYAnchor, constant: 0).isActive = true
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
