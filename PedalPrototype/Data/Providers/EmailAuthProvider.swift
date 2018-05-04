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
    
    static func singOut() -> Promise<Void> {
        let requestURL: String = Constants.API.URL_AUTH
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .delete).responseJSON { responseData in
                                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Auth_Loggout", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Auth_Loggout", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
            
        }
    }
}
