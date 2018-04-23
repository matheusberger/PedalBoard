//
//  TuneSetup+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 31/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import SwiftyJSON

extension PedalSetup {
    
    static func from(data: JSON) -> PedalSetup? {
        
        guard let pedalId = data["pedal"].string else {
            return nil
        }
        
        guard let knobsValues = data["knobsValue"].array else {
            return nil
        }
        
        let knobs: [Knob] = knobsValues.compactMap{ Knob.fromPedalSetup(data: $0) }
        
        return PedalSetup(withPedalId: pedalId, withKnobs: knobs)
    }
}
