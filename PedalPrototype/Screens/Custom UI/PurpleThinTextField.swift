//
//  PurpleThinTextField.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 07/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleThinTextField: PurpleTextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.frame.size.height = 20
    }

}
