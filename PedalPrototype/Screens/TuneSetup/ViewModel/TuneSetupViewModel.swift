//
//  TuneSetupViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneSetupViewModel: TuneSetupViewModelProtocol {
    
    var tune: Tune
    
    init(withTune tune: Tune) {
        self.tune = tune
        
        if self.tune.tuneSetup == nil {
            self.tune.tuneSetup = TuneSetup()
        }
    }
    
    func getTuneSetup() {
        
        for pedal in self.tune.tuneSetup!.pedals {
            print("getting the setup for \(pedal.name)")
        }
        
        TuneSetupProvider.getSetup(forTune: self.tune, forUser: PBUserProvider.getCurrentUserUID()!) { () in
            //show new setup
            print("just found a setup for \(self.tune.tuneSetup!.pedals.last!.name)")
            print("the setup is:")
            
            for (knob, value) in (self.tune.tuneSetup!.pedals.last?.knobs)! {
                print("\(knob) : \(value)")
            }
        }
    }
    
    func saveTuneSetup(withCompletionBlock completionBlock: @escaping () -> Void) {
        
        guard let userUID = PBUserProvider.getCurrentUserUID() else {
            return
        }
        
         var setup = self.tune.tuneSetup!
    
        for pedal in setup.pedals {
            for (knobName, value) in pedal.knobs {
                pedal.knobs[knobName] = 69
            }
        }
        
        self.tune.tuneSetup = setup
        
        TuneSetupProvider.createSetup(forTune: self.tune, forUser: userUID) {
            completionBlock()
        }
    }
}
