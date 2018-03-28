//
//  PedalListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListViewModel: PedalListViewModelProtocol, PedalSourceProtocol {
    
    weak var delegate: PedalListViewModelDelegate?
    
    fileprivate var pedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
    func getPedals() {
        PedalProvider.getPedals(forUser: PBUserProvider.getCurrentUserUID()!) { (pedal) in
            self.pedals.append(pedal)
        }
    }
    
    func getPedalList() -> [Pedal] {
        return self.pedals
    }
    
    func getPedalCellViewModel(forIndex index: Int) -> PedalTableViewCellViewModelProtocol {
        return PedalTableViewCellViewModel(withPedal: self.pedals[index])
    }
    
    func getPedalCount() -> Int {
        return self.pedals.count
    }
}
