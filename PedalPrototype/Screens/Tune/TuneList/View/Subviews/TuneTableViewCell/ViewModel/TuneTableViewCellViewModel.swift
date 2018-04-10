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
    private var index: Int
    
    weak var delegate: TuneTableViewCellViewModelDelegate?
    
    init(withTune tune: Tune, inIndex index: Int) {
        self.tune = tune
        self.index = index
    }
    
    func getTuneName() -> String {
        return self.tune.name
    }
    
    func getArtistName() -> String {
        return tune.artist
    }
    
    func selectTune() {
         self.delegate?.didSelectSetup(atIndex: self.index)
    }
}
