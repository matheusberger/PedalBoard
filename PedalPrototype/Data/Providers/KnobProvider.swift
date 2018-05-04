//
//  KnobProvider.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class KnobProvider: KnobProtocol {
    
    static func load(withId id: String) -> Promise<Knob> {
        
        let requestURL: String = String(format: Constants.API.URL_KNOB_ID, id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .get).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Knob_Read", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let knob: Knob = Knob.from(data: jsonData) else {
                        let error = NSError(domain: "Knob_Read", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(knob)
                    
                } else {
                    let error = NSError(domain: "Knob_Read", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func create(withName name: String) -> Promise<Knob> {
        
        let requestURL: String = Constants.API.URL_KNOB
        
        let requestParameters: Parameters = [
            "name": name
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .post,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Knob_Create", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let knob: Knob = Knob.from(data: jsonData) else {
                        let error = NSError(domain: "Knob_Create", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(knob)
                    
                } else {
                    let error = NSError(domain: "Knob_Create", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func updateName(knob: Knob) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_KNOB_ID_NAME, knob.id)
        
        let requestParameters: Parameters = [
            "name": knob.name
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .patch,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
                                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Knob_UpdateName", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Knob_UpdateName", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
        
    static func delete(knob: Knob) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_KNOB_ID, knob.id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .delete).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Knob_Remove", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Knob_Remove", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
}
