//
//  ProfileViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class ProfileViewModel: ProfileViewModelProtocol {
    
    fileprivate var currentUser: PBUser
    fileprivate var pedalsViewModel: PedalListViewModelProtocol
    
    init() {
        self.currentUser = PBUserProvider.getCurrentUser()!
        self.pedalsViewModel = PedalListViewModel()
        self.pedalsViewModel.getPedals()
    }
    
    func getUserName() -> String {
        return currentUser.name
    }
    
    func getUserEmail() -> String {
        return currentUser.email
    }
    
    func getNumberOfPedals() -> Int {
        return self.pedalsViewModel.getPedalCount()
    }
    
    func getPedalListViewModel() -> PedalListViewModelProtocol {
        return self.pedalsViewModel
    }
}
