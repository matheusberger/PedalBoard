//
//  Tune.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class Tune {
    
    var key: String?
    
    var name: String
    var pedals: [String]
    
    init(withKey key: String? = nil, withName name: String, andPedals pedals: [String]) {
        
        self.key = key
        
        self.name = name
        self.pedals = pedals
    }
}
