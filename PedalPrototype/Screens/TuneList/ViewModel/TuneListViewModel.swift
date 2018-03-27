//
//  TuneListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneListViewModel: TuneListViewModelProtocol {
    
    fileprivate var tunes: [Tune] = []
    
    func getTunes() {
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return
        }
        
        TuneProvider.getTunes(forUser: user.uid!) { (tune) in
            self.tunes.append(tune)
        }
    }
    
    func getCreateTuneViewModel() -> CreateTuneViewModelProtocol {
        return CreateTuneViewModel()
    }
}
