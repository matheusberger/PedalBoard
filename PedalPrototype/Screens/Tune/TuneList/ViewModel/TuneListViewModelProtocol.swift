//
//  TuneListViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneListViewModelProtocol {
    
    var filter: String? { get set }
    
    var selectedTune: Int? { get set }
    
    var delegate: TuneListViewModelDelegate? { get set }
    
    func getTunes()
    
    func getTuneCount() -> Int
    
    func getTuneCellViewModel(forIndex: Int) -> TuneTableViewCellViewModelProtocol
    
    func getConfigureTuneViewModel() -> ConfigureTuneViewModelProtocol
}
