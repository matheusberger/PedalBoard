//
//  PedalListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit
import PromiseKit

class PedalListViewModel: PedalListViewModelProtocol, PedalTableViewCellViewModelDelegate {
    
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
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let requestPedals = user.pedalsId.map { (pedalId) in
            
            return PedalProvider.load(withId: pedalId).then { pedal -> Promise<Void> in
                
                let knobsRequest = pedal.knobs.map { knob -> Promise<Knob> in
                    return KnobProvider.load(withId: knob.id)
                }
                
                return when(fulfilled: knobsRequest).done { (knobs) in
                    pedal.knobs = knobs
                    
                    self.pedals.append(pedal)
                }
            }
        }
        
        when(fulfilled: requestPedals).ensure {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { error in
                
                let error = error as NSError
                if let requestEndpoint = RequestEndpoint(rawValue: error.domain) {
                    let requestError = RequestError.from(endpoint: requestEndpoint, withHttpErrorCode: error.code)
                    //TODO: handle requestError!
                }
        }
    }
    
    func getPedalCellViewModel(forIndex index: Int) -> PedalTableViewCellViewModelProtocol {
        
        var viewModel: PedalTableViewCellViewModel
        
        if self.filter == "" || self.filter == nil {
            viewModel = PedalTableViewCellViewModel(withPedal: self.pedals[index])
        }
        else {
            viewModel = PedalTableViewCellViewModel(withPedal: self.filteredPedals[index])
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
        
//        var knobs: [String : Int]
//        
////        if self.filter == "" || self.filter == nil {
////            knobs = self.pedals[index].knobs
////        }
////        else {
////            knobs = self.filteredPedals[index].knobs
////        }
//        
//        let knobCount = knobs.keys.count
//        
//        if knobCount > 5 {
//            return 158
//        }
        
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
