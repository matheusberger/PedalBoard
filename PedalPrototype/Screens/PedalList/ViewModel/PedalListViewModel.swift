//
//  PedalListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListViewModel: NSObject, PedalListViewModelProtocol {
    
    weak var delegate: PedalListViewModelDelegate?
    
    private var pedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
    func getPedals() {
        
        PedalProvider.getPedals(forUser: "user_key") { (pedal) in
            self.pedals.append(pedal)
        }
    }
    
    func getPedalCellViewModel(forIndex index: Int) -> PedalTableViewCellViewModelProtocol {
        return PedalTableViewCellViewModel(withPedal: self.pedals[index])
    }
    
    func getPedalCount() -> Int {
        return self.pedals.count
    }
    

}
