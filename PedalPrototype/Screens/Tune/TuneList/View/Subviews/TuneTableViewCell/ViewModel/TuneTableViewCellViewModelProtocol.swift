//
//  TuneTableViewCellViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 28/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol TuneTableViewCellViewModelProtocol {
    
    var delegate: TuneTableViewCellViewModelDelegate? { get set }
    
    func getTuneName() -> String
    
    func getArtistName() -> String
    
    func selectTune()
}
