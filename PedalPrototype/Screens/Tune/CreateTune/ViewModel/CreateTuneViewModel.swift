//
//  CreateTuneViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class CreateTuneViewModel: CreateTuneViewModelProtocol {

    var tune: Tune?
    var pedals: [Pedal]
    
    init(withPedals pedals: [Pedal]) {
        self.pedals = pedals
    }
    
    func createTune(withName name: String,andArtist artist: String, withCompletionBlock completionBlock: @escaping () -> Void) {
        let tune = Tune(withName: name, withArtist: artist)
        TuneProvider.create(tune: tune, forUser: PBUserProvider.getCurrentUserID()!) { (success) in
            if success {
                self.tune = tune
                completionBlock()
            }
        }
    }
    
    func getTuneSetupViewModel(forIndexPaths indexPaths: [IndexPath]) -> TuneSetupViewModel {
        
        var selectedPedals = [Pedal]()
        
        for index in indexPaths {
            selectedPedals.append(self.pedals[index.row])
        }
        
        let setup = TuneSetup(withPedals: selectedPedals)
        self.tune?.tuneSetup = setup
        
        return TuneSetupViewModel(withTune: tune!)
    }
    
    func getPedalForExhibition(atIndex index: Int) -> String {
        return self.pedals[index].name
    }
    
    func getPedalCount() -> Int {
        return self.pedals.count
    }
}
