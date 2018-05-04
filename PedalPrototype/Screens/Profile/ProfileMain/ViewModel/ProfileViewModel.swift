//
//  ProfileViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 10/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

class ProfileViewModel: ProfileViewModelProtocol {
    
    fileprivate var currentUser: PBUser
    
    init() {
        self.currentUser = PBUserProvider.getCurrentUser()!
    }
    
    func getUserName() -> String {
        return self.currentUser.name
    }
    
    func getUserEmail() -> String {
        return self.currentUser.email
    }
    
    func getNumberOfPedals() -> Int {
        return self.currentUser.pedalsId.count
    }
    
    func logout(withCompletionBlock completionBlock: @escaping () -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        firstly {
            EmailAuthProvider.singOut()
        }.done {
            completionBlock()
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
}
