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
}
