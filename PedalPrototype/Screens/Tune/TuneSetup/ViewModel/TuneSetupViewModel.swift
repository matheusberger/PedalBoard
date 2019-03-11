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
    
    var filter: String? {
        didSet {
            self.filteredPedals = []
            for pedal in self.pedals {
                if pedal.name.lowercased().contains(filter!) {
                    self.filteredPedals.append(pedal)
                }
            }
        }
    }
    
    fileprivate var filteredPedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
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
        if filter == "" || filter == nil {
            return self.pedals.count
        }
        else {
            return self.filteredPedals.count
        }
    }
    
    func getTVCHeightForPedal(atIndex index: IndexPath) -> Int {
        if self.pedals[index.row].knobs.keys.count > 5 {
            return 158
        }
        else {
            return 112
        }
    }
    
    func getTuneSetupCVCViewModelForPedal(atIndex index: IndexPath) -> TuneSetupCVCViewModelProtocol {
        var pedal: Pedal
        if filter == "" || filter == nil {
            pedal = self.pedals[index.row]
        }
        else {
            pedal = self.filteredPedals[index.row]
        }
        
        let belongs = self.indexOfPedals.contains(index.row)
        return TuneSetupCVCViewModel(withPedal: pedal, active: belongs)
    }
}
