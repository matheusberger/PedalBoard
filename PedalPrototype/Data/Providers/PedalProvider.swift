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

class PedalProvider: PedalProtocol {
    
    static func load(withId id: String,
                     withCompletionBlock completionBlock: @escaping (Pedal) -> Void,
                     withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
        let requestURL = String(format: Constants.API.URL_PEDAL_ID, id)
        
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
                    
                    if let pedal = Pedal.from(data: jsonData) {
                        completionBlock(pedal)
                    } else {
                        failureBlock(.Unexpected)
                    }
                    
                case 401:
                    failureBlock(.NotAuthenticated)
                case 404:
                    failureBlock(.PedalNotFound)
                default:
                    failureBlock(.Unexpected)
                }
        }
        
    }
    
    static func create(withName name: String, andKnobs knobs: [Knob],
                       withCompletionBlock completionBlock: @escaping (Pedal) -> Void,
                       withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
    }
    
    static func delete(pedal: Pedal,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
    }
    
    static func updateName(pedal: Pedal,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
    }
    
    static func associate(pedal: Pedal, knob: Knob,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
    }
    
    static func dissociate(pedal: Pedal, knob: Knob,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (PedalRequestError) -> Void) {
        
    }
}
