//
//  RoundView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class RoundView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 10
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
