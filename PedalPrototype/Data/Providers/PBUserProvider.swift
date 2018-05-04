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
    
    static func associate(user: PBUser, withPedal pedal: Pedal) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_USER_ID_PEDAL_ID, user.id, pedal.id)

        return Promise { seal in
            
            Alamofire.request(requestURL, method: .put).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "User_Pedal_Link", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "User_Pedal_Link", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
}
