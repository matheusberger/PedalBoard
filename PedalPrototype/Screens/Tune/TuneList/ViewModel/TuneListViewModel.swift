//
//  TuneListViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

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
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let requestTunes = user.tunesId.map { (tuneId) -> Promise<Tune> in
            return TuneProvider.load(withId: tuneId)
        }
        
        when(fulfilled: requestTunes).done { (tunes) in
            self.tunes = tunes
        }.ensure {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { error in
            
            let error = error as NSError
            if let requestEndpoint = RequestEndpoint(rawValue: error.domain) {
                let requestError = RequestError.from(endpoint: requestEndpoint, withHttpErrorCode: error.code)
                //TODO: handle requestError!
            }
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
