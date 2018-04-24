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
    
//    static func load(withId id: String, withCompletionBlock completionBlock: @escaping (Knob) -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
//
//    }
//
//    static func create(withName name: String, withCompletionBlock completionBlock: @escaping (Knob) -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
//
//    }
//
//    static func updateName(knob: Knob, withCompletionBlock completionBlock: @escaping () -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
//
//    }
//
//    static func delete(knob: Knob, withCompletionBlock completionBlock: @escaping () -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
//
//    }
}
