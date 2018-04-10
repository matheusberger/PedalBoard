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
    var artist: String
    var tuneSetup: TuneSetup?
    
    
    init(withKey key: String? = nil, withName name: String, withArtist artist: String, andTuneSetup config: TuneSetup? = nil) {
        
        self.key = key
        
        self.name = name
        self.artist = artist
        self.tuneSetup = config
    }
    
    func toDictionary() -> [String : Any] {
        var dictionary: [String : Any] = [String : Any]()
        
        dictionary["name"] = self.name
        dictionary["artist"] = self.artist
        
        return dictionary
    }
}
