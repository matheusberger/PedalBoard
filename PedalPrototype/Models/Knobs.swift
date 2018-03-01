//
//  Nobs.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

struct Knob {
    var name: String
    var value: Int
    
    init(withName name: String, andValue value: Int) {
        self.name = name
        self.value = value
    }
}
