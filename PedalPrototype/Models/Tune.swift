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
    var tuneSetup: TuneSetup?
    
    
    init(withKey key: String? = nil, withName name: String, andTuneSetup config: TuneSetup? = nil) {
        
        self.key = key
        
        self.name = name
        self.tuneSetup = config
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String : Any] = [String : Any]()
        
        dictionary["name"] = self.name
        
        return dictionary
    }
}
