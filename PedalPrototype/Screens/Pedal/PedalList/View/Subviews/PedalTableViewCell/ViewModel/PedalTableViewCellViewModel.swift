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
    
    private var pedal: Pedal?
    
    init(withPedal pedal: Pedal?) {
        self.pedal = pedal
    }
    
    func getPedalName() -> String {
        
        guard let pedal = self.pedal else {
             return ""
        }
       
        return pedal.name
    }
    
    func getKnobs() -> [String : Int] {
        
        guard let pedal = self.pedal else {
            return [String : Int]()
        }

        return [:]
//        return pedal.knobs
    }
    
    func edit() {
        self.delegate?.setEditingPedal(pedal: self.pedal!)
    }
}
