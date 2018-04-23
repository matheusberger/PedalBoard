//
//  EmailAuthProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EmailAuthProvider: AuthProtocol {
    
    static func singIn(withEmail email: String,
                           andPassword password: String,
                           withCompletionBlock completionBlock: @escaping (String) -> Void,
                           withFailureBlock failureBlock: @escaping (AuthRequestError) -> Void) {
        
        let requestParameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(Constants.API.URL_AUTH, method: .post, parameters: requestParameters, encoding: JSONEncoding.default)
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
                    
                    guard let userUID = jsonData["user"]["id"].string else {
                        failureBlock(.Unexpected)
                        return
                    }
                    
                    completionBlock(userUID)
                case 401:
                    failureBlock(.AlreadyAuthenticated)
                case 403:
                    failureBlock(.CredentialsIncorrect)
                case 404:
                    failureBlock(.UserNotFound)
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
    
    static func signOut(withCompletionBlock completionBlock: @escaping () -> Void,
                            withFailureBlock failureBlock: @escaping (AuthRequestError) -> Void) {
        
        Alamofire.request(Constants.API.URL_AUTH, method: .delete)
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
                default:
                    failureBlock(.Unexpected)
                }
        }
    }
    
}
