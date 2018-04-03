//
//  PedalTableViewCellViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class PedalTableViewCellViewModel: PedalTableViewCellViewModelProtocol {
    
    private var pedal: Pedal
    
    init(withPedal pedal: Pedal) {
        self.pedal = pedal
    }
    
    func getPedalName() -> String {
        return self.pedal.name
    }
}
