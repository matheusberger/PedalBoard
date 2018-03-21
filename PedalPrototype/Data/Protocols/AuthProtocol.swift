//
//  AuthProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 17/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol AuthProtocol {
    
    static func createUser(withEmail: String,
                           password: String,
                           andName: String,
                           withCompletionBlock: @escaping (_ user: PBUser?, Error?) -> Void)
    
    static func singInUser(withEmail: String,
                          andPassword: String,
                          withCompletionBlock: @escaping (_ user: PBUser?, Error?) -> Void)
    
    static func signOutUser(withCompletionBlock: @escaping (_ success: Bool) -> Void)
    
}
