//
//  Tune.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class Tune {
    
    var id: String
    
    var name: String
    var artist: String
    
    var pedalSetups: [PedalSetup]
    
    init(withId id: String,
         withName name: String,
         withArtist artist: String,
         andPedalSetups pedalSetups: [PedalSetup]) {
        
        self.id = id
        self.name = name
        self.artist = artist
        self.pedalSetups = pedalSetups
    }
}
