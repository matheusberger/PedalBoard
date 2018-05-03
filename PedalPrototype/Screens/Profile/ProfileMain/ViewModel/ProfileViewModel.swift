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
    
    init() {
        self.currentUser = PBUserProvider.getCurrentUser()!
    }
    
    func getUserName() -> String {
        return currentUser.name
    }
    
    func getUserEmail() -> String {
        return currentUser.email
    }
    
    func getNumberOfPedals() -> Int {
        return 0
    }
    
    func logout(withCompletionBlock completionBlock: @escaping () -> Void) {
        EmailAuthProvider.signOutUser { (success) in
            if success {
                completionBlock()
            }
            else {
                print("deu ruim")
            }
        }
    }
}
