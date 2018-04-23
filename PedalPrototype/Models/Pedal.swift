//
//  Pedal.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class Pedal {
    
    var id: String
    
    var name: String
    var knobs: [Knob]
    
    init(withId id: String, withName name: String, andKnobs knobs: [Knob]) {
        self.id = id
        
        self.name = name
        self.knobs = knobs
    }
}
