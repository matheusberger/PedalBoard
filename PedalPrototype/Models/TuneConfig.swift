//
//  TuneConfig.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneConfig {
    
    var pedals: [Pedal]
    
    init(withPedals pedals:[Pedal]? = nil) {
        
        self.pedals = pedals!
    }
    
    func addPedal(pedal: Pedal, withConfig config: [String : Any]) {
        
        for (knobName, value) in config {
            pedal.knobs[knobName] = value as? Int
        }
    }
}
