//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PBUserProtocol {
    
    static func setCurrent(user: PBUser)
    
    static func removeCurrent()
    
    static func getCurrentUser() -> PBUser?
    
    static func getCurrentUserID() -> String?
    
    static func load(withId id: String,
                     withCompletionBlock completionBlock: @escaping (_ user: PBUser) -> Void,
                     withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
    static func create(withEmail email: String,
                       password: String,
                       andName name: String,
                       withCompletionBlock completionBlock: @escaping (_ user: PBUser) -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
//    static func update(user: PBUser, withCompletionBlock: @escaping (_ error: Error?) -> Void)
}
