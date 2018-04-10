//
//  TuneListViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneListViewModelProtocol {
    
    var delegate: TuneListViewModelDelegate? { get set }
    
    func getTunes()
    
    func getTuneCellViewModel(forIndex: Int) -> TuneTableViewCellViewModelProtocol
    
    func getCreateTuneViewModel() -> CreateTuneViewModelProtocol
    
    func getTuneSetupViewModel(forTuneInIndex: Int) -> TuneSetupViewModelProtocol
}
