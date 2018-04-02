//
//  CreateTuneViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 24/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol CreateTuneViewModelProtocol {
    
    func createTune(withName: String,
                    withCompletionBlock: @escaping () -> Void)
    
    func getPedalForExhibition(atIndex: Int) -> String
    
    func getPedalCount() -> Int
    
    func getTuneSetupViewModel(forIndexPaths: [IndexPath]) -> TuneSetupViewModel
}
