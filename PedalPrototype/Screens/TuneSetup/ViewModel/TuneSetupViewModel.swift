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
    weak var delegate: TuneSetupViewModelDelegate?
    
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
            
            self.delegate?.didUpdateSetupList()
        }
    }
    
    func saveTuneSetup(withCompletionBlock completionBlock: @escaping () -> Void) {
        
        guard let userUID = PBUserProvider.getCurrentUserUID() else {
            return
        }
        
        //meu fake bizarro
         let setup = self.tune.tuneSetup!
    
        for pedal in setup.pedals {
            for (knobName, _) in pedal.knobs {
                pedal.knobs[knobName] = 69
            }
        }
        
        self.tune.tuneSetup = setup
        //termina aqui
        
        TuneSetupProvider.createSetup(forTune: self.tune, forUser: userUID) {
            completionBlock()
        }
    }
    
    func getPedalCount() -> Int {
        
        let setup = self.tune.tuneSetup!
        
        return setup.pedals.count
    }
    
    func getPedal(atIndex index: Int) -> [String : Any] {
        
        let setup = self.tune.tuneSetup!
        
        return setup.pedals[index].toDictionary()
    }
    
    func getPedalName(atIndex index: Int) -> String {
        
        let setup = self.tune.tuneSetup!
        
        return setup.pedals[index].name
    }
    
    func getKnob(forPedalAtSection section: Int, withIndex index: Int) -> [String : Int] {
        
        let setup = self.tune.tuneSetup!
        let pedal = setup.pedals[section]
        
        let knobs = Array(pedal.knobs.keys)
        let knob = [knobs[index] : pedal.knobs[knobs[index]]!]
        
        return knob
    }
    
    func getKnobsCount(forPedalAtIndex index: Int) -> Int {
        
        let setup = self.tune.tuneSetup!
        
        return setup.pedals[index].knobs.count
    }
    
    func getKnobSetupViewModel(forPedalAtSection section: Int, withIndex index: Int) -> KnobSetupTVCViewModel {
        
        let setup = self.tune.tuneSetup!
        let pedal = setup.pedals[section]
        
        let knobs = Array(pedal.knobs.keys)
        let knobName = knobs[index]
        
        return KnobSetupTVCViewModel(withName: knobName, andValue: pedal.knobs[knobName]!)
    }
}
