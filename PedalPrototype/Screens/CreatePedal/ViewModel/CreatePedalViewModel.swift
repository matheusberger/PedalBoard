//
//  CreatePedalViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class CreatePedalViewModel: NSObject, CreatePedalViewModelProtocol {
    
    
    
    func createPedal(withName name: String, andKnobs knobNames: [String], withCompletionBlock completionBlock: @escaping () -> Void) {
        
        var knobs = [Knob]()
        
        for name in knobNames {
            knobs.append(Knob(withName: name, andValue: 0))
        }
        
        let pedal = Pedal(withName: name, andKnobs: knobs)
        PedalProvider.create(pedal: pedal, forUser: PBUserProvider.getCurrentUserUID()!) { (success: Bool) in
            completionBlock()
        }
    }
}
