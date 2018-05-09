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
    
    var filter: String? {
        didSet {
            self.filteredTunes = []
            for tune in self.tunes {
                if tune.name.lowercased().contains(filter!) {
                    self.filteredTunes.append(tune)
                }
            }
        }
    }
    
    fileprivate var filteredTunes: [Tune] = [] {
        didSet {
            self.delegate?.didUpdateTuneList()
        }
    }
    
    var selectedTune: Int?
    fileprivate var tunes: [Tune] = [] {
        didSet {
            self.delegate?.didUpdateTuneList()
        }
    }
    
    func getTunes() {
        
        let user = PBUserProvider.getCurrentUser()
        
        TuneProvider.getTunes(forUser: user.uid!) { (tune) in
            self.tunes.append(tune)
        }
    }
    
    func getTuneCount() -> Int {
        if filter == "" || filter == nil {
            return self.tunes.count
        }
        else {
           return self.filteredTunes.count
        }
    }
    
    func getTuneCellViewModel(forIndex index: Int) -> TuneTableViewCellViewModelProtocol {
        if filter == "" || filter == nil {
            return TuneTableViewCellViewModel(withTune: self.tunes[index], inIndex: index)
        }
        else {
            return TuneTableViewCellViewModel(withTune: self.filteredTunes[index], inIndex: index)
        }
    }
    
    func getConfigureTuneViewModel() -> ConfigureTuneViewModelProtocol {
        
        guard let selected = self.selectedTune else {
            return ConfigureTuneViewModel()
        }

        return ConfigureTuneViewModel(withTune: self.tunes[selected])
    }
}
