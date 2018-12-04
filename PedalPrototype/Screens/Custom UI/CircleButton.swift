//
//  CircleImageView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.layer.frame.size.width/2
        
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
        self.imageView?.layer.cornerRadius = self.layer.cornerRadius
        self.imageView?.contentMode = .scaleAspectFill
    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        self.purple(source: image, for: state)
    }
    
    fileprivate func purple(source: UIImage?, for state: UIControl.State) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        
        let purple = UIColor.hanPurple
        purple.setFill()
        
        let bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        UIRectFill(bounds)
        
        var image = source
        image?.draw(in: bounds, blendMode: .hardLight, alpha: 1)
        image = UIGraphicsGetImageFromCurrentImageContext()
        
        super.setImage(image, for: state)
        
        UIGraphicsEndImageContext()
    }
}
