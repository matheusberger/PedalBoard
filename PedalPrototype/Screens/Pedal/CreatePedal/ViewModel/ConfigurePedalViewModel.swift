//
//  CreatePedalViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class ConfigurePedalViewModel: ConfigurePedalViewModelProtocol {
    
    var pedal: Pedal
    
    init(withPedal pedal: Pedal?) {
        
        if pedal != nil {
            self.pedal = pedal!
        }
        else {
            self.pedal = Pedal(withName: "", andKnobs: [String : Int]())
        }
    }
    
    func configurePedal(withName name: String, andKnobs knobNames: [String], withCompletionBlock completionBlock: @escaping () -> Void) {
        
        guard let userUID = PBUserProvider.getCurrentUserUID() else {
            return
        }
        
        var knobs = [String : Int]()
        
        for name in knobNames {
            knobs[name] = 0
        }
        
        self.pedal.name = name
        self.pedal.knobs = knobs
        
        if pedal.key != nil {
            PedalProvider.update(pedal: self.pedal, forUser: userUID) { (success) in
                completionBlock()
            }
        }
        else {
            PedalProvider.create(pedal: self.pedal, forUser: userUID) { (success) in
                completionBlock()
            }
        }
    }
    
    func getPedalName() -> String {
        return self.pedal.name
    }
}
