//
//  PBUserProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

protocol PBUserProtocol {
    
    static func setCurrent(user: PBUser)
    
    static func removeCurrent()
    
    static func getCurrentUser() -> PBUser?

    static func getCurrentUserID() -> String?
    
    
    static func load(withId id: String) -> Promise<PBUser>
    
    static func create(withEmail email: String, withPassword password: String, andName name: String) -> Promise<Void>
    
    
    
//    static func updateName(user: PBUser,
//                       withCompletionBlock completionBlock: @escaping () -> Void,
//                       withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
//    
//    static func associate(user: PBUser, pedal: Pedal,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
//    
//    static func dissociate(user: PBUser, pedal: Pedal,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
//    
//    static func associate(user: PBUser, tune: Tune,
//                          withCompletionBlock completionBlock: @escaping () -> Void,
//                          withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
//    
//    static func dissociate(user: PBUser, tune: Tune,
//                           withCompletionBlock completionBlock: @escaping () -> Void,
//                           withFailureBlock failureBlock: @escaping (_ error: UserRequestError) -> Void)
    
}
