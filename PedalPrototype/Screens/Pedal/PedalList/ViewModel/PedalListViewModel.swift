//
//  PedalListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit

class PedalListViewModel: PedalListViewModelProtocol, PedalTVCViewModelDelegate {
    
    var filter: String? {
        didSet {
            self.filteredPedals = []
            for pedal in self.pedals {
                if pedal.name.lowercased().contains(filter!) {
                    self.filteredPedals.append(pedal)
                }
            }
        }
    }
    
    weak var delegate: PedalListViewModelDelegate?
    
    fileprivate var selectedPedal: Pedal?
    
    fileprivate var filteredPedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
    fileprivate var pedals: [Pedal] = [] {
        didSet {
            self.delegate?.didUpdatePedalList()
        }
    }
    
    func getPedals() {
        
        guard let userUID = PBUserProvider.getCurrentUser().uid else {
            return
        }
        
        PedalProvider.getPedals(forUser: userUID) { (pedal) in
            self.pedals.append(pedal)
        }
    }
    
    func getPedalCellViewModel(forIndex index: Int) -> PedalTVCViewModelProtocol {
        
        var viewModel: PedalTVCViewModel
        
        if self.filter == "" || self.filter == nil {
            viewModel = PedalTVCViewModel(withPedal: self.pedals[index])
        }
        else {
            viewModel = PedalTVCViewModel(withPedal: self.filteredPedals[index])
        }
    
        viewModel.delegate = self
        
        return viewModel
    }
    
    func getPedalCount() -> Int {
        if self.filter == "" || self.filter == nil {
            return self.pedals.count
        }
        else {
            return self.filteredPedals.count
        }
    }
    
    func getCellHeight(forIndex index: Int) -> Int {
        
        var knobs: [String : Int]
        
        if self.filter == "" || self.filter == nil {
            knobs = self.pedals[index].knobs
        }
        else {
            knobs = self.filteredPedals[index].knobs
        }
        
        let knobCount = knobs.keys.count
        
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
