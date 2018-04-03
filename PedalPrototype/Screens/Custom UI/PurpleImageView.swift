//
//  PurpleImageView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        UIGraphicsBeginImageContextWithOptions(self.image!.size, false, 0.0)
        
        let purple = UIColor(displayP3Red: 77/255, green: 5/255, blue: 253/255, alpha: 1)
        purple.setFill()
        
        let bounds = CGRect(x: 0, y: 0, width: self.image!.size.width, height: self.image!.size.height)
        UIRectFill(bounds)
        
        self.image?.draw(in: bounds, blendMode: .hardLight, alpha: 1)
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
}
