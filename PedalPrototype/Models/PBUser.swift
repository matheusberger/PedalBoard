//
//  User.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 17/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class PBUser {
    
    var id: String
    var email: String
    var name: String
    var pedals: [String]
    var tunes: [String]
    
    init(withID id: String,
         withEmail email: String,
         withName name: String,
         withPedals pedals: [String],
         withTunes tunes: [String]) {
        
        self.id = id
        self.email = email
        self.name = name
        self.pedals = pedals
        self.tunes = tunes
    }
}
