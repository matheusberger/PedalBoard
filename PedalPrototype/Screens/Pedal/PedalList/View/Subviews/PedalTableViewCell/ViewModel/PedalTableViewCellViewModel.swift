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
        
//        if pedal != nil {
            self.pedal = pedal!
//        }
//        else {
//            self.pedal = Pedal(withId: <#T##String#>, withName: <#T##String#>, andKnobs: <#T##[Knob]#>)
//            self.pedal = Pedal(withName: "", andKnobs: [String : Int]())
//        }
        
    }
    
    func getPedalName() -> String {
        return pedal.name
    }
    
    func getKnobCount() -> Int {
        return self.pedal.knobs.count
    }
      
    func getKnobs() -> [String : Int] {
        
        return pedal.knobs.reduce(into: [String: Int]()) {
            $0[$1.name] = $1.value
        }
    }
    
    func getKnobCollectionViewCellViewModel(forIndexPath index: IndexPath) -> KnobCollectionViewCellViewModel {
        let knobName = self.pedal.knobs[index.row].name
        return KnobCollectionViewCellViewModel(withName: knobName, andPercentage: 50)
    }
    
    func edit() {
        self.delegate?.setEditingPedal(pedal: self.pedal)
    }
}
