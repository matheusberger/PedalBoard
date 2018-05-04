//
//  PedalProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 01/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class PedalProvider: PedalProtocol {
    
    static func load(withId id: String) -> Promise<Pedal> {
        
        let requestURL: String = String(format: Constants.API.URL_PEDAL_ID, id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .get).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Pedal_Read", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let pedal: Pedal = Pedal.from(data: jsonData) else {
                        let error = NSError(domain: "Pedal_Read", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(pedal)
                    
                } else {
                    let error = NSError(domain: "Pedal_Read", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func create(withName name: String, andKnobs knobs: [Knob]) -> Promise<Pedal> {
        
        let requestURL: String = Constants.API.URL_PEDAL
        
        let knobsIds: [String] = knobs.map { (knob) -> String in
            return knob.id
        }
        
        let requestParameters: Parameters = [
            "name": name,
            "knobs": knobsIds
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .post,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
                                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Pedal_Create", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let pedal: Pedal = Pedal.from(data: jsonData) else {
                        let error = NSError(domain: "Pedal_Create", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(pedal)
                    
                } else {
                    let error = NSError(domain: "Pedal_Create", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func updateName(pedal: Pedal) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_PEDAL_ID_NAME, pedal.id)
        
        let requestParameters: Parameters = [
            "name": pedal.name
        ]
        
        return Promise { seal in
            
            Alamofire.request(requestURL,
                              method: .patch,
                              parameters: requestParameters,
                              encoding: JSONEncoding.default).responseJSON { responseData in
                    
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Pedal_UpdateName", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Pedal_UpdateName", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func associate(knob: Knob, withPedal pedal: Pedal) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_PEDAL_ID_KNOB_ID, pedal.id, knob.id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .put).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Pedal_Knob_Link", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Pedal_Knob_Link", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
    static func dissociate(knob: Knob, withPedal pedal: Pedal) -> Promise<Void> {
        
        let requestURL: String = String(format: Constants.API.URL_PEDAL_ID_KNOB_ID, pedal.id, knob.id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .delete).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200 else {
                        let error = NSError(domain: "Pedal_Knob_Unlink", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.resolve(nil)
                    
                } else {
                    let error = NSError(domain: "Pedal_Knob_Unlink", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
}
