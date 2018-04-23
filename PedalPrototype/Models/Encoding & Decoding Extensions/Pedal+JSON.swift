//
//  Pedal+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Pedal {
    
    static func from(data: JSON) -> Pedal? {
        
        guard let id = data["_id"].string else {
            return nil
        }
        
        guard let name = data["name"].string else {
            return nil
        }
        
        var knobs: [Knob] = []
        if let knobsData = data["knobs"].array {
            knobs = knobsData.compactMap{ $0.string }.map{ Knob(withId: $0) }
        }
        
        return Pedal(withId: id, withName: name, andKnobs: knobs)
    }
}
