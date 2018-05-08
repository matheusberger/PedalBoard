//
//  PurpleImageView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleImageView: UIImageView {
    
    var isPurple: Bool!
    
    override var image: UIImage? {
        didSet {
            self.purple()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isPurple = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isPurple = false
        
        self.purple()
    }
    
    fileprivate func purple() {
        if !self.isPurple {
            UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
            
            let purple = UIColor.hanPurple
            purple.setFill()
            
            let bounds = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            UIRectFill(bounds)
            self.isPurple = true
            
            self.image?.draw(in: bounds, blendMode: .hardLight, alpha: 1)
            self.image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
        }
    }
}
