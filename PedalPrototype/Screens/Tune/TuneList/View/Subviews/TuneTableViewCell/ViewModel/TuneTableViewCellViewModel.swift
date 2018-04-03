//
//  TuneTableViewCellViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneTableViewCellViewModel: TuneTableViewCellViewModelProtocol {
    
    private var tune: Tune!
    
    init(withTune tune: Tune) {
        self.tune = tune
    }
    
    func getTuneName() -> String {
        return self.tune.name
    }
}
