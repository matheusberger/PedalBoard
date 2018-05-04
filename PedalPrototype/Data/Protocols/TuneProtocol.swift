//
//  TuneProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import PromiseKit

protocol TuneProtocol {
    
    static func load(withId id: String) -> Promise<Tune>
}
