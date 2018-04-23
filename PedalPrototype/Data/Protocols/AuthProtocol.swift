//
//  AuthProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 17/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol AuthProtocol {
    
    static func singIn(withEmail email: String,
                           andPassword password: String,
                           withCompletionBlock completionBlock: @escaping (_ userId: String) -> Void,
                           withFailureBlock failureBlock: @escaping (_ error: AuthRequestError) -> Void) //ok
    
    static func signOut(withCompletionBlock completionBlock: @escaping () -> Void,
                            withFailureBlock failureBlock: @escaping (_ error: AuthRequestError) -> Void) //ok
    
}
