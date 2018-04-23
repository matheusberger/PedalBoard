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
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return
        }
        
        TuneProvider.getTunes(forUser: user.id) { (tune) in
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
    
    func getCreateTuneViewModel() -> CreateTuneViewModelProtocol {
        
        let viewModel = CreateTuneViewModel(withPedals: [Pedal]())
        
        return viewModel
    }
    
    func getTuneSetupViewModel(forTuneInIndex index: Int) -> TuneSetupViewModelProtocol {
        return TuneSetupViewModel(withTune: self.tunes[index])
    }
    
}
