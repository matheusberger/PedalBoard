//
//  TuneSetupCVCViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 20/02/19.
//  Copyright © 2019 mcb3. All rights reserved.
//

import Foundation

class TuneSetupCVCViewModel: TuneSetupCVCViewModelProtocol {
    
    var pedal: Pedal
    var isActive: Bool
    
    init(withPedal pedal: Pedal, active: Bool) {
        self.pedal = pedal
        self.isActive = active
    }
    
    func getPedalName() -> String {
        return self.pedal.name
    }
    
    func isPedalActive() -> Bool {
        return false
    }
}
