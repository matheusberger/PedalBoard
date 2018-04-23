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
    var knobs: [Knob]
    
    init(withKey key: String? = nil, withName name: String, andKnobs knobs: [Knob]) {
        self.key = key
        
        self.name = name
        self.knobs = knobs
    }
    
//    func toDictionary() -> [String : Any] {
//
//        var dictionary: [String : Any] = [String : Any]()
//
//        var knobsDictionary: [String : Int] = [String : Int]()
//
//        for (knob, value) in self.knobs {
//            knobsDictionary[knob] = value
//        }
//
//        dictionary["name"] = self.name
//        dictionary["knobs"] = knobsDictionary
//
//        return dictionary
//    }
}
