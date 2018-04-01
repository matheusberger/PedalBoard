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
        
        TuneSetupProvider.getSetup(forTune: self.tune, forUser: PBUserProvider.getCurrentUserUID()!) { () in
            //show new setup
            print("just found a setup for \(self.tune.tuneSetup!.pedals.last!.name)")
        }
    }
}
