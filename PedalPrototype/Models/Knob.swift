//
//  Knob.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class Knob {
    
    var id: String
    
    var name: String
    var value: Int
    
    init(withId id: String, withName name: String = "Information not available", andValue value: Int = 0) {
        self.id = id
        self.name = name
        self.value = value
    }
}
