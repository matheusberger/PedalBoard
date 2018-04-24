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
    
//    static func load(withId id: String,
//                     withCompletionBlock completionBlock: @escaping (Pedal) -> Void,
//                     withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//        let requestURL = String(format: Constants.API.URL_PEDAL_ID, id)
//        
//        Alamofire.request(requestURL, method: .get)
//            .responseJSON { (responseData) in
//                
//                guard let status = responseData.response?.statusCode else {
//                    failureBlock(.Unexpected)
//                    return
//                }
//                
//                switch (status) {
//                case 200:
//                    guard let response = responseData.result.value else {
//                        failureBlock(.Unexpected)
//                        return
//                    }
//                    
//                    let jsonData = JSON(response)
//                    
//                    if let pedal = Pedal.from(data: jsonData) {
//                        completionBlock(pedal)
//                    } else {
//                        failureBlock(.Unexpected)
//                    }
//                    
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 404:
//                    failureBlock(.PedalNotFound)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//        
//    }
//    
//    static func create(withName name: String, andKnobs knobs: [Knob],
//                       withCompletionBlock completionBlock: @escaping (Pedal) -> Void,
//                       withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//    }
//    
//    static func delete(pedal: Pedal,
//                       withCompletionBlock completionBlock: @escaping () -> Void,
//                       withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//    }
//    
//    static func updateName(pedal: Pedal,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//    }
//    
//    static func associate(pedal: Pedal, knob: Knob,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//    }
//    
//    static func dissociate(pedal: Pedal, knob: Knob,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
//        
//    }
}
