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
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func setup() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.textColor = UIColor.hanPurple
        
        
        var placeholder = self.placeholder
        if placeholder == nil {
            placeholder = ""
        }
        
        self.autocorrectionType = .default
        self.keyboardType = .default
        self.clearButtonMode = .never
        self.contentHorizontalAlignment = .leading
        self.contentVerticalAlignment = .center
        self.borderStyle = .roundedRect
        self.autocapitalizationType = .none
        
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.blueChalk])
        
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.blueChalk.cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
        
        self.font = UIFont(name: "Futura", size: 10)
        
    }

}
