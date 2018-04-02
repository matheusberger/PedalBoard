//
//  CreatePedalViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class CreatePedalViewModel: CreatePedalViewModelProtocol {
    
    func createPedal(withName name: String, andKnobs knobNames: [String], withCompletionBlock completionBlock: @escaping () -> Void) {
        
        var knobs = [String : Int]()
        
        for name in knobNames {
            knobs[name] = 0
        }
        
        let pedal = Pedal(withName: name, andKnobs: knobs)
        PedalProvider.create(pedal: pedal, forUser: PBUserProvider.getCurrentUserUID()!) { (success: Bool) in
            completionBlock()
        }
    }
}
