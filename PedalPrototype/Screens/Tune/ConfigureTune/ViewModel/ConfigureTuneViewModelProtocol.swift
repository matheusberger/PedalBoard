//
//  ConfigureTuneViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol ConfigureTuneViewModelProtocol {
    
    func createTune(withName: String, andArtist: String,
                    withCompletionBlock: @escaping () -> Void)
    
    func getTuneSetupViewModel() -> TuneSetupViewModel
    
    func getTuneName() -> String
    
    func getArtistName() -> String
}
