//
//  Knob.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class Knob {
    
    var key: String?
    
    var name: String
    var value: Int
    
    init(withKey key: String? = nil, withName name: String, andValue value: Int) {
        self.key = key
        
        self.name = name
        self.value = value
    }
}
