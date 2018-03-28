//
//  Pedal.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class Pedal {
    
    var key: String?
    
    var name: String
    var knobs: [String : Int]
    
    
    init(withKey key: String? = nil, withName name: String, andKnobs knobs: [String : Int]) {
        
        self.key = key
        self.name = name
        self.knobs = knobs
    }
    
    func toDictionary() -> [String : Any] {
        
        var dictionary: [String : Any] = [String : Any]()
        
        var knobsDictionary: [String : Bool] = [String : Bool]()
        
        for (knob,_) in self.knobs {
            knobsDictionary[knob] = true
        }
        
        dictionary["name"] = self.name
        dictionary["knobs"] = knobsDictionary
        
        return dictionary
    }
}
