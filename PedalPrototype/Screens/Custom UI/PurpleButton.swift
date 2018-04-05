//
//  PurpleRoundButton.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.hanPurple
        self.setTitleColor(UIColor.white, for: .normal)
        
        self.layer.cornerRadius = 10
    }

}
