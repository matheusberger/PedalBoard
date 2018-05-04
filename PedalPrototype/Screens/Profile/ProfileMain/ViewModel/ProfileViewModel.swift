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
    
    
    func getUserName() -> String {
        guard let user = PBUserProvider.getCurrentUser() else {
            return ""
        }
        
        return user.name
    }
    
    func getUserEmail() -> String {
        guard let user = PBUserProvider.getCurrentUser() else {
            return ""
        }
        
        return user.email
    }
    
    func getNumberOfPedals() -> Int {
        guard let user = PBUserProvider.getCurrentUser() else {
            return 0
        }
        
        return user.pedalsId.count
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
