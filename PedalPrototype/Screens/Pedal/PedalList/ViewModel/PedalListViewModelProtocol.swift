//
//  PedalListViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalListViewModelProtocol {
    
    var filter: String? { get set }
    
    var delegate: PedalListViewModelDelegate? { get set }
    
    func getPedals()
    
    func getPedalCount() -> Int
    
    func getCellHeight(forIndex: Int) -> Int
    
    func getPedalCellViewModel(forIndex: Int) -> PedalTableViewCellViewModelProtocol
    
    func getCreatePedalViewModel() -> ConfigurePedalViewModelProtocol
    
    func clearSelectedPedal()
    
    func didCreate(pedal: Pedal)
    
    func didEdit(pedal: Pedal)
}
