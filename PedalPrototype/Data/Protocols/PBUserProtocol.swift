//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol PBUserProtocol {
    
    static func setCurrent(user: PBUser) //ok
    
    static func removeCurrent() //ok
    
    static func getCurrentUser() -> PBUser? //ok
    
    static func getCurrentUserID() -> String? //ok
    
    static func load(withId id: String,
                     withCompletionBlock completionBlock: @escaping (_ user: PBUser) -> Void,
                     withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) //ok
    
    static func create(withEmail email: String,
                       password: String,
                       andName name: String,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void) //ok
    
    static func updateName(user: PBUser,
                       withCompletionBlock completionBlock: @escaping () -> Void,
                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
    static func associate(user: PBUser, pedal: Pedal,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
    static func dissociate(user: PBUser, pedal: Pedal,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
    static func associate(user: PBUser, tune: Tune,
                          withCompletionBlock completionBlock: @escaping () -> Void,
                          withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
    static func dissociate(user: PBUser, tune: Tune,
                           withCompletionBlock completionBlock: @escaping () -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
}
