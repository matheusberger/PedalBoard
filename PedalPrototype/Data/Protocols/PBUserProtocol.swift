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
    
    static func associate(user: PBUser, withPedal pedal: Pedal) -> Promise<Void>
}
