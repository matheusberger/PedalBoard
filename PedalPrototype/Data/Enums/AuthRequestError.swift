//
//  AuthRequestError.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

enum AuthRequestError {
    case UserNotFound, CredentialsIncorrect, AlreadyAuthenticated, NotAuthenticated, Unexpected
}
