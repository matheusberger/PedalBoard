//
//  PurpleNegativeButton.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleNegativeButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.backgroundColor = UIColor.white
        self.setTitleColor(UIColor.hanPurple, for: .normal)
        
        self.layer.borderColor = UIColor.hanPurple.cgColor
        self.layer.borderWidth = 0.5
        
        self.layer.cornerRadius = 10
    }

}
