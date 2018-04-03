//
//  PurpleButton.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.hanPurple
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.layer.cornerRadius = 10
        
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 20)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
