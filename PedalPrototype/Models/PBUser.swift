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
    
    var pedalsId: [String]
    var tunesId: [String]
    
    init(withID id: String,
         withEmail email: String,
         withName name: String,
         withPedalsId pedalsId: [String],
         withTunesId tunesId: [String]) {
        
        self.id = id
        self.email = email
        self.name = name
        self.pedalsId = pedalsId
        self.tunesId = tunesId
    }
}
