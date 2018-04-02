//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PBUserProtocol {
    
    static func getCurrentUser() -> PBUser?
    static func getCurrentUserUID() -> String?
    
    static func update(user: PBUser, withCompletionBlock: @escaping (_ error: Error?) -> Void)
}
