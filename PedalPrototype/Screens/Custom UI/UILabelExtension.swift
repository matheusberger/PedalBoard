//
//  UILabelExtension.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    @IBInspectable
    var letterSpace: CGFloat {
        set {
            let attributedString: NSMutableAttributedString!
            if let currentAttrString = attributedText {
                attributedString = NSMutableAttributedString(attributedString: currentAttrString)
            }
            else {
                attributedString = NSMutableAttributedString(string: text ?? "")
                text = nil
            }
            
            attributedString.addAttribute(kCTKernAttributeName as NSAttributedString.Key,
                                          value: newValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            
            attributedText = attributedString
        }
        
        get {
            if let currentLetterSpace = attributedText?.attribute(kCTKernAttributeName as NSAttributedString.Key, at: 0, effectiveRange: .none) as? CGFloat {
                return currentLetterSpace
            }
            else {
                return 0
            }
        }
    }
}
