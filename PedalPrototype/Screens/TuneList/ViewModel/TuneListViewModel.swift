//
//  TuneListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class TuneListViewModel: TuneListViewModelProtocol {
    
    weak var delegate: TuneListViewModelDelegate?
    
    fileprivate var tunes: [Tune] = [] {
        didSet {
            self.delegate?.didUpdateTuneList()
        }
    }
    
    func getTunes() {
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return
        }
        
        TuneProvider.getTunes(forUser: user.uid!) { (tune) in
            self.tunes.append(tune)
        }
    }
    
    func getTuneCount() -> Int {
        return self.tunes.count
    }
    
    func getTuneCellViewModel(forIndex index: Int) -> TuneTableViewCellViewModelProtocol {
        return TuneTableViewCellViewModel(withTune: self.tunes[index])
    }
    
    func getCreateTuneViewModel() -> CreateTuneViewModelProtocol {
        return CreateTuneViewModel()
    }
    
    func getTuneSetupViewModel() -> TuneSetupViewModelProtocol {
        return TuneSetupViewModel()
    }
    
}
