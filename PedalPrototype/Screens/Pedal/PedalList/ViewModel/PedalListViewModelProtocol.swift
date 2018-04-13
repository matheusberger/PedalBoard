//
//  PedalListViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalListViewModelProtocol {
    
    var delegate: PedalListViewModelDelegate? { get set }
    
    func getPedals()
    
    func getPedalCount() -> Int
    
    func getPedalCellViewModel(forIndex: Int) -> PedalTableViewCellViewModelProtocol
    
    func getCreatePedalViewModel() -> ConfigurePedalViewModelProtocol
}
