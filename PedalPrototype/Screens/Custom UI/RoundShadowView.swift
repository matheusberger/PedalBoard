//
//  RoundShadowView.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class RoundShadowView: RoundView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.shadowColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.layer.shadowRadius = 3.5
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}
