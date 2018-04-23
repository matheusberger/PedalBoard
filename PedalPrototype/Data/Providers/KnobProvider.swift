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

class KnobProvider: KnobProtocol {
    
    static func load(withId id: String, withCompletionBlock completionBlock: @escaping (Knob) -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
        
    }
    
    static func create(withName name: String, withCompletionBlock completionBlock: @escaping (Knob) -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
        
    }
    
    static func updateName(knob: Knob, withCompletionBlock completionBlock: @escaping () -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
        
    }
    
    static func delete(knob: Knob, withCompletionBlock completionBlock: @escaping () -> Void, withFailureBlock failureBlock: @escaping (KnobRequestError) -> Void) {
        
    }
}
