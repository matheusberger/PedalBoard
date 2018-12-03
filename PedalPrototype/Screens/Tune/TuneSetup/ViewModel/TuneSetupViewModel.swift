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
    var pedals: [Pedal]
    var indexOfPedals: [Int]
    
    weak var delegate: TuneSetupViewModelDelegate?
    
    init(withTune tune: Tune) {
        self.tune = tune
        self.pedals = []
        self.indexOfPedals = []
        
        if tune.tuneSetup == nil {
            tune.tuneSetup = TuneSetup()
        }
        
        if let userUID = PBUserProvider.getCurrentUser().uid {
            PedalProvider.getPedals(forUser: userUID) { (pedal) in
                self.pedals.append(pedal)
                self.delegate?.didUpdatePedalList()
                if (self.tune.tuneSetup?.contains(pedal))! {
                    self.indexOfPedals.append(self.pedals.endIndex)
                }
            }
        }
    }
    
    func getNumberOfPedals() -> Int {
        return self.pedals.count
    }
    
    func getTVCHeightForPedal(atIndex index: IndexPath) -> Int {
        if self.pedals[index.row].knobs.keys.count > 5 {
            return 158
        }
        else {
            return 112
        }
    }
    
    func getTuneSetupTVCViewModelForPedal(atIndex index: IndexPath) -> TuneSetupTVCViewModelProtocol {
    
        let pedal = self.pedals[index.row]
        let belongs = self.indexOfPedals.contains(index.row)
        return TuneSetupTVCViewModel(withPedal: pedal, inSetup: belongs)
    }
}
