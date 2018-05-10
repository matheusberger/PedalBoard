//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PBUserProtocol {
    
    static func observeCurrentUser()
    
    static func userDataIsAvailable(completionBlock: @escaping () -> Void)
    
    static func getUserImage()
    
    static func update(user: PBUser, withCompletionBlock: @escaping (_ error: Error?) -> Void)
}
