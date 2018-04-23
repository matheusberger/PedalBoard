//
//  TuneSetup.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class PedalSetup {
    
    var pedalId: String
    
    var knobs: [Knob]
    
    init(withPedalId pedalId: String, withKnobs knobs: [Knob]) {
        self.pedalId = pedalId
        self.knobs = knobs
    }
}
