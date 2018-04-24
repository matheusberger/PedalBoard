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
import PromiseKit

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
    
    static func load(withId id: String) -> Promise<PBUser> {
       
        let requestURL: String = String(format: Constants.API.URL_USER_ID, id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .get).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "User_Read", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let user: PBUser = PBUser.from(data: jsonData) else {
                        let error = NSError(domain: "User_Read", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(user)
                    
                } else {
                    let error = NSError(domain: "User_Read", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func create(withEmail email: String, withPassword password: String, andName name: String) -> Promise<Void> {
       
        let requestURL: String = Constants.API.URL_USER
        
        let requestParameters: Parameters = [
            "email": email,
            "password": password,
            "name": name
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .post,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
            
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "User_Create", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "User_Create", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
//    static func updateName(user: PBUser,
//                       withCompletionBlock completionBlock: @escaping () -> Void,
//                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) {
//
//        let requestURL = String(format: Constants.API.URL_USER_ID_NAME, user.id)
//
//        let requestParameters: Parameters = [
//            "name": user.name
//        ]
//
//        Alamofire.request(requestURL, method: .patch, parameters: requestParameters, encoding: JSONEncoding.default)
//            .responseJSON { (responseData) in
//
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//
//                switch (status) {
//                case 200:
//                    completionBlock()
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 409:
//                    failureBlock(.AuthenticationNotAllowed)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
//
//    static func associate(user: PBUser, pedal: Pedal,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
//
//        let requestURL = String(format: Constants.API.URL_USER_ID_PEDAL_ID, user.id, pedal.id)
//
//        Alamofire.request(requestURL, method: .put)
//            .responseJSON { (responseData) in
//
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//
//                switch (status) {
//                case 200:
//                    completionBlock()
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 403:
//                    failureBlock(.PedalAlredyAssociated)
//                case 404:
//                    failureBlock(.PedalNotFound)
//                case 409:
//                    failureBlock(.AuthenticationNotAllowed)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
//
//    static func dissociate(user: PBUser, pedal: Pedal,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
//
//        let requestURL = String(format: Constants.API.URL_USER_ID_PEDAL_ID, user.id, pedal.id)
//
//        Alamofire.request(requestURL, method: .delete)
//            .responseJSON { (responseData) in
//
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//
//                switch (status) {
//                case 200:
//                    completionBlock()
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 403:
//                    failureBlock(.PedalNotAssociated)
//                case 404:
//                    failureBlock(.PedalNotFound)
//                case 409:
//                    failureBlock(.AuthenticationNotAllowed)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
//
//    static func associate(user: PBUser, tune: Tune,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
//
//        let requestURL = String(format: Constants.API.URL_USER_ID_TUNE_ID, user.id, tune.id)
//
//        Alamofire.request(requestURL, method: .put)
//            .responseJSON { (responseData) in
//
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//
//                switch (status) {
//                case 200:
//                    completionBlock()
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 403:
//                    failureBlock(.TuneAlreadyAssociated)
//                case 404:
//                    failureBlock(.TuneNotFound)
//                case 409:
//                    failureBlock(.AuthenticationNotAllowed)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
//
//    static func dissociate(user: PBUser, tune: Tune,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (UserRequestError) -> Void) {
//
//        let requestURL = String(format: Constants.API.URL_USER_ID_TUNE_ID, user.id, tune.id)
//
//        Alamofire.request(requestURL, method: .delete)
//            .responseJSON { (responseData) in
//
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//
//                switch (status) {
//                case 200:
//                    completionBlock()
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 403:
//                    failureBlock(.TuneNotAssociated)
//                case 404:
//                    failureBlock(.TuneNotFound)
//                case 409:
//                    failureBlock(.AuthenticationNotAllowed)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
}
