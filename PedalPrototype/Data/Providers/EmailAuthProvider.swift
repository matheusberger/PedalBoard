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
import PromiseKit

class EmailAuthProvider: AuthProtocol {
    
    static func singIn(withEmail email: String, andPassword password: String) -> Promise<String> {

        let requestURL: String = Constants.API.URL_AUTH
        
        let requestParameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .post,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Auth_Login", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let userId = jsonData["user"]["id"].string else {
                        let error = NSError(domain: "Auth_Login", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(userId)
                
                } else {
                    let error = NSError(domain: "Auth_Login", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
//    static func signOut(withCompletionBlock completionBlock: @escaping () -> Void,
//                            withFailureBlock failureBlock: @escaping (AuthRequestError) -> Void) {
//
//        Alamofire.request(Constants.API.URL_AUTH, method: .delete)
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
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
    
}
