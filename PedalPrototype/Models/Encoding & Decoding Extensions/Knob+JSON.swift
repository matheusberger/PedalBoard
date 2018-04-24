//
//  Knob+JSON.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Knob {
    
    static func from(data: JSON) -> Knob? {
        
        guard let id = data["_id"].string else {
            return nil
        }
        
        guard let name = data["name"].string else {
            return nil
        }
        
        return Knob(withId: id, withName: name)
    }
    
    static func fromPedalSetup(data: JSON) -> Knob? {
        
        guard let id = data["knob"].string else {
            return nil
        }
        
        guard let value = data["knob"].int else {
            return nil
        }
        
        return Knob(withId: id, andValue: value)
    }
}
