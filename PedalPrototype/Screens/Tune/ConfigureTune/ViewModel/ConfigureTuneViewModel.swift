//
//  ConfigureTuneViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class ConfigureTuneViewModel: ConfigureTuneViewModelProtocol {

    var tune: Tune
    
    init(withTune tune: Tune? = nil) {
        
//        if tune != nil {
            self.tune = tune!
//        }
//        else {
//            self.tune = Tune(withName: "", withArtist: "")
//        }
    }
    
    func createTune(withName name: String,andArtist artist: String, withCompletionBlock completionBlock: @escaping () -> Void) {
//        let tune = Tune(withName: name, withArtist: artist)
//        TuneProvider.create(tune: tune, forUser: PBUserProvider.getCurrentUserUID()!) { (success) in
//            if success {
//                self.tune = tune
//                completionBlock()
//            }
//        }
    }
    
    func getTuneSetupViewModel() -> TuneSetupViewModel {
        return TuneSetupViewModel(withTune: self.tune)
    }
    
    func getTuneName() -> String {
        return self.tune.name
    }
    
    func getArtistName() -> String {
        return self.tune.artist
    }
}
