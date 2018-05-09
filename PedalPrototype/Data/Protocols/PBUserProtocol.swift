//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PBUserProtocol {
    
    var user: PBUser! { get set }
    
    static var shared: PBUserProvider { get }
    
    static func getCurrentUser() -> PBUser
    
    static func getUserImage()
    
    static func observeCurrentUser()
    
    static func update(user: PBUser, withCompletionBlock: @escaping (_ error: Error?) -> Void)
}
