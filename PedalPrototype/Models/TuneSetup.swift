//
//  TuneSetup.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneSetup {
    
    var pedals: [Pedal]
    
    init(withPedals pedals:[Pedal]? = []) {
        
        self.pedals = pedals!
    }
}
