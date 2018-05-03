//
//  PedalTableViewCellViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PedalTableViewCellViewModelProtocol {
    
    var delegate: PedalTableViewCellViewModelDelegate? { get set }
    
    func getPedalName() -> String
    
    func getKnobCount() -> Int
    
    func getKnobCollectionViewCellViewModel(forIndexPath: IndexPath) -> KnobCollectionViewCellViewModel
    
    func edit()
}
