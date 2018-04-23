//
//  PedalListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListViewModel: PedalListViewModelProtocol, PedalTableViewCellViewModelDelegate {
    
    weak var delegate: PedalListViewModelDelegate?
    
    var selectedPedal: Pedal?
    
    fileprivate var pedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
    func getPedals() {
        PedalProvider.getPedals(forUser: PBUserProvider.getCurrentUserID()!) { (pedal) in
            self.pedals.append(pedal)
        }
    }
    
    func getPedalCellViewModel(forIndex index: Int) -> PedalTableViewCellViewModelProtocol {
        
        let viewModel = PedalTableViewCellViewModel(withPedal: self.pedals[index])
        viewModel.delegate = self
        
        return viewModel
    }
    
    func getPedalCount() -> Int {
        return self.pedals.count
    }
    
    func getCellHeight(forIndex index: Int) -> Int {
        let knobs = self.pedals[index].knobs
        let knobCount = 0//knobs.keys.count
        
        if knobCount > 5 {
            return 158
        }
        
        return 112
    }
    
    func getCreatePedalViewModel() -> ConfigurePedalViewModelProtocol {
        return ConfigurePedalViewModel(withPedal: self.selectedPedal)
    }
    
    func setEditingPedal(pedal: Pedal) {
        self.selectedPedal = pedal
        self.delegate?.editPedal()
    }
    
    func clearSelectedPedal() {
        self.selectedPedal = nil
    }
}
