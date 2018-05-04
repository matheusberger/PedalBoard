//
//  AuthProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 17/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

protocol AuthProtocol {
    
    static func singIn(withEmail email: String, andPassword password: String) -> Promise<String>
    
    static func singOut() -> Promise<Void>

}
