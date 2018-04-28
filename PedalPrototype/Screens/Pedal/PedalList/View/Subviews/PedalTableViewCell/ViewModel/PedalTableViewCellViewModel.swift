//
//  PedalTableViewCellViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class PedalTableViewCellViewModel: PedalTableViewCellViewModelProtocol {
    
    weak var delegate: PedalTableViewCellViewModelDelegate?
    
    private var pedal: Pedal
    
    init(withPedal pedal: Pedal? = nil) {
        
        if pedal != nil {
            self.pedal = pedal!
        }
        else {
            self.pedal = Pedal(withName: "", andKnobs: [String : Int]())
        }
        
    }
    
    func getPedalName() -> String {
        return pedal.name
    }
    
    func getKnobCount() -> Int {
        return self.pedal.knobs.keys.count
    }
    
    func getKnobCollectionViewCellViewModel(forIndexPath index: IndexPath) -> KnobCollectionViewCellViewModel {
        let keys = Array(self.pedal.knobs.keys)
        let knobKey = keys[index.row]
        return KnobCollectionViewCellViewModel(withName: knobKey, andPercentage: self.pedal.knobs[knobKey]!)
    }
    
    func edit() {
        self.delegate?.setEditingPedal(pedal: self.pedal)
    }
}
