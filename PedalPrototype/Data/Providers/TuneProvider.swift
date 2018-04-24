//
//  TuneProvider.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 27/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class TuneProvider: TuneProtocol {
    
    static func load(withId id: String) -> Promise<Tune> {
       
        let requestURL: String = String(format: Constants.API.URL_TUNE_ID, id)
        
        return Promise { seal in
            
            Alamofire.request(requestURL, method: .get).responseJSON { responseData in
                
                if let responseCode = responseData.response?.statusCode {
                    
                    guard responseCode == 200, let responseData = responseData.result.value else {
                        let error = NSError(domain: "Tune_Read", code: responseCode, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    let jsonData = JSON(responseData)
                    
                    guard let tune: Tune = Tune.from(data: jsonData) else {
                        let error = NSError(domain: "Tune_Read", code: 501, userInfo: nil)
                        seal.reject(error)
                        return
                    }
                    
                    seal.fulfill(tune)
                    
                } else {
                    let error = NSError(domain: "Tune_Read", code: 501, userInfo: nil)
                    seal.reject(error)
                }
            }
        }
    }
    
//    static func load(withId id: String,
//                     withCompletionBlock completionBlock: @escaping (Tune) -> Void,
//                     withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//        let requestURL = String(format: Constants.API.URL_TUNE_ID, id)
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
//                    if let tune = Tune.from(data: jsonData) {
//                        completionBlock(tune)
//                    } else {
//                        failureBlock(.Unexpected)
//                    }
//                    
//                case 401:
//                    failureBlock(.NotAuthenticated)
//                case 404:
//                    failureBlock(.TuneNotFound)
//                default:
//                    failureBlock(.Unexpected)
//                }
//        }
//    }
//    
//    static func create(withName name: String, andArtist artist: String,
//                       withCompletionBlock completionBlock: @escaping (Tune) -> Void,
//                       withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func updateName(tune: Tune,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func updateArtist(tune: Tune,
//                             withCompletionBlock completionBlock: @escaping () -> Void,
//                             withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func delete(tune: Tune,
//                       withCompletionBlock completionBlock: @escaping () -> Void,
//                       withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func associate(tune: Tune, pedal: Pedal,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func dissociate(tune: Tune, pedal: Pedal,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
//    
//    static func updateValue(tune: Tune, pedal: Pedal, knob: Knob,
//                            withCompletionBlock completionBlock: @escaping () -> Void,
//                            withFailureBlock failureBlock: @escaping (TuneRequestError) -> Void) {
//        
//    }
}
