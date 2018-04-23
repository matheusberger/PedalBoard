//
//  UserRequestError.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

enum UserRequestError {
    case NotAuthenticated
    case AuthenticationNotAllowed
    case EmailAlreadyRegistered
    case UserNotFound
    case PedalNotFound
    case TuneNotFound
    case PedalAlredyAssociated
    case PedalNotAssociated
    case TuneAlreadyAssociated
    case TuneNotAssociated
    case Unexpected
}
