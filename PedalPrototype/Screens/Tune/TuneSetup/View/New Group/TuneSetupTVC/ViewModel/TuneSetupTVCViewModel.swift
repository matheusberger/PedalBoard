//
//  TuneSetupTVCViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 23/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneSetupTVCViewModel: TuneSetupTVCViewModelProtocol {
    
    var pedal: Pedal
    var belongsToSetup: Bool
    
    init(withPedal pedal: Pedal, inSetup: Bool? = false) {
        self.pedal = pedal
        self.belongsToSetup = inSetup!
    }
    
    func getPedalName() -> String {
        return self.pedal.name
    }
}
