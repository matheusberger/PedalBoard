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
    weak var delegate: TuneSetupViewModelDelegate?
    
    init(withTune tune: Tune) {
        self.tune = tune
        self.pedals = []
        
        if self.tune.tuneSetup == nil {
            self.tune.tuneSetup = TuneSetup()
        }
    }
    
    func getTuneSetup() {
        
        guard let userUID = PBUserProvider.getCurrentUser().uid else {
            return
        }
        
        PedalProvider.getPedals(forUser: userUID) { (pedal) in
            self.pedals.append(pedal)
            self.delegate?.didUpdatePedalList()
            
            TuneSetupProvider.getSetup(forTune: self.tune, forPedal: pedal, forUser: userUID, withCompletionBlock: {
                self.delegate?.didUpdateSetup()
            })
        }
    }
    
    func saveTuneSetup(withCompletionBlock completionBlock: @escaping () -> Void) {
        
        guard let userUID = PBUserProvider.getCurrentUser().uid else {
            return
        }
        
        TuneSetupProvider.createSetup(forTune: self.tune, forUser: userUID) {
            completionBlock()
        }
    }
    
    func getPedalCount() -> Int {
        return self.pedals.count
    }
    
    func getPedalName(atIndex index: Int) -> String {
        return self.pedals[index].name
    }
    
    func updateSetupForPedal(atIndex index: Int, forKnobNamed knobName: String, withValue value: Int) {
        
        let setup = self.tune.tuneSetup!
        
        setup.pedals[index].knobs[knobName] = value
    }
    
    func getKnob(forPedalAtSection section: Int, withIndex index: Int) -> [String : Int] {
    
        let pedal = self.pedals[section]
        
        let knobs = Array(pedal.knobs.keys)
        let knob = [knobs[index] : pedal.knobs[knobs[index]]!]
        
        return knob
    }
    
    func getKnobsCount(forPedalAtIndex index: Int) -> Int {
        
        return self.pedals[index].knobs.count
    }
    
    func getKnobSetupViewModel(forPedalAtSection section: Int, withIndex index: Int) -> KnobSetupTVCViewModel {
        
        let pedal = self.pedals[section]
        
        let knobs = Array(pedal.knobs.keys)
        let knobName = knobs[index]
        
        let viewModel = KnobSetupTVCViewModel(withName: knobName, andValue: pedal.knobs[knobName]!) { (value) in
            pedal.knobs[knobName] = value
        }
        return viewModel
    }
}
