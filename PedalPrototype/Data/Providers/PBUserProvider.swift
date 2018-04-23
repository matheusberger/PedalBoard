//
//  PBUserProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PBUserProvider: PBUserProtocol {
    
    static func setCurrent(user: PBUser) {
        let userJSONString = user.toJSONString()
        
        UserDefaults.standard.set(userJSONString, forKey: "PBUser.default")
    }
    
    static func removeCurrent() {
        UserDefaults.standard.removeObject(forKey: "PBUser.default")
    }
    
    static func getCurrentUser() -> PBUser? {
        guard let userJSONString = UserDefaults.standard.string(forKey: "PBUser.default") else {
            return nil
        }
        
        return PBUser.from(jsonString: userJSONString)
    }
    
    static func getCurrentUserID() -> String? {
        guard let user = self.getCurrentUser() else {
            return nil
        }
        
        return user.id
    }
    
    static func load(withId id: String,
                     withCompletionBlock completionBlock: @escaping (PBUser) -> Void,
                     withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID, id)
        
        Alamofire.request(requestURL, method: .get)
            .responseJSON { (responseData) in
    
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    guard let response = responseData.result.value else {
                        failureBlock(.Unexpected)
                        return
                    }
                    
                    let jsonData = JSON(response)
                    
                    if let user = PBUser.from(data: jsonData) {
                        completionBlock(user)
                    } else {
                        failureBlock(.Unexpected)
                    }
                case 401:
                    failureBlock(.NotAuthenticated)
                case 404:
                    failureBlock(.UserNotFound)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func create(withEmail email: String,
                       password: String,
                       andName name: String,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestParameters: Parameters = [
            "email": email,
            "password": password,
            "name": name
        ]
        
        Alamofire.request(Constants.API.URL_USER, method: .post, parameters: requestParameters, encoding: JSONEncoding.default)
            .responseJSON{ (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 403:
                    failureBlock(.EmailAlreadyRegistered)
                default:
                    failureBlock(.Unexpected)
                }
                
            }
    }
    
    static func updateName(user: PBUser,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID_NAME, user.id)
        
        let requestParameters: Parameters = [
            "name": user.name
        ]
        
        Alamofire.request(requestURL, method: .patch, parameters: requestParameters, encoding: JSONEncoding.default)
            .responseJSON { (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 401:
                    failureBlock(.NotAuthenticated)
                case 409:
                    failureBlock(.AuthenticationNotAllowed)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func associate(user: PBUser, pedal: Pedal,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID_PEDAL_ID, user.id, pedal.id)
        
        Alamofire.request(requestURL, method: .put)
            .responseJSON { (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 401:
                    failureBlock(.NotAuthenticated)
                case 403:
                    failureBlock(.PedalAlredyAssociated)
                case 404:
                    failureBlock(.PedalNotFound)
                case 409:
                    failureBlock(.AuthenticationNotAllowed)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func dissociate(user: PBUser, pedal: Pedal,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID_PEDAL_ID, user.id, pedal.id)
        
        Alamofire.request(requestURL, method: .delete)
            .responseJSON { (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 401:
                    failureBlock(.NotAuthenticated)
                case 403:
                    failureBlock(.PedalNotAssociated)
                case 404:
                    failureBlock(.PedalNotFound)
                case 409:
                    failureBlock(.AuthenticationNotAllowed)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func associate(user: PBUser, tune: Tune,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID_TUNE_ID, user.id, tune.id)
        
        Alamofire.request(requestURL, method: .put)
            .responseJSON { (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 401:
                    failureBlock(.NotAuthenticated)
                case 403:
                    failureBlock(.TuneAlreadyAssociated)
                case 404:
                    failureBlock(.TuneNotFound)
                case 409:
                    failureBlock(.AuthenticationNotAllowed)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func dissociate(user: PBUser, tune: Tune,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID_TUNE_ID, user.id, tune.id)
        
        Alamofire.request(requestURL, method: .delete)
            .responseJSON { (responseData) in
                
                guard let status = responseData.response?.statusCode else {
                    failureBlock(.Unexpected)
                    return
                }
                
                switch (status) {
                case 200:
                    completionBlock()
                case 401:
                    failureBlock(.NotAuthenticated)
                case 403:
                    failureBlock(.TuneNotAssociated)
                case 404:
                    failureBlock(.TuneNotFound)
                case 409:
                    failureBlock(.AuthenticationNotAllowed)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
}
