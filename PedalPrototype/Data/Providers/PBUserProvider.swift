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
                     withCompletionBlock completionBlock: @escaping (_ user: PBUser) -> Void,
                     withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_USER_ID, id)
        
        Alamofire.request(requestURL, method: .get)
            .validate(contentType: ["application/json"])
            .responseJSON { (responseData) -> Void in
                switch (responseData.result) {
                case .success(let response):
                    
                    guard let status = responseData.response?.statusCode else {
                        failureBlock(.Unexpected)
                        return
                    }
                    
                    switch (status) {
                    case 401:
                        failureBlock(.NotAuthenticated)
                    case 404:
                        failureBlock(.UserNotFound)
                    case 200:
                        let jsonData = JSON(response)
                        if let user = PBUser.from(data: jsonData) {
                            completionBlock(user)
                        } else {
                            failureBlock(.Unexpected)
                        }
                    default:
                        failureBlock(.Unexpected)
                    }
                    
                case .failure(_):
                    failureBlock(.Unexpected)
                }
        }
    }
    
    static func create(withEmail email: String,
                       password: String,
                       andName name: String,
                       withCompletionBlock completionBlock: @escaping (_ user: PBUser) -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) {
        
    }
}
