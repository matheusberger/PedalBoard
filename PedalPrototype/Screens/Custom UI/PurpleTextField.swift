//
//  PurpleTextField.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 06/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PurpleTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.backgroundColor = UIColor.concrete.cgColor
        self.textColor = UIColor.hanPurple
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.blueChalk])
        
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.blueChalk.cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
    }

}
