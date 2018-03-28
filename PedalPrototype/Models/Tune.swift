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
    var tuneConfig: TuneConfig?
    
    
    init(withKey key: String? = nil, withName name: String, andTuneConfig config: TuneConfig? = nil) {
        
        self.key = key
        
        self.name = name
        self.tuneConfig = config
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String : Any] = [String : Any]()
        
        dictionary["name"] = self.name
        
        return dictionary
    }
}
