//
//  AuthRequestError.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

enum RequestEndpoint {
    case Auth.Login
    case Auth.Loggout
    
    case User.Create
    case User.Read
    case User.UpdateName
    case User.Remove
    case User.Pedal.Link
    case User.Pedal.Unlink
    case User.Tune.Link
    case User.Tune.Unlink
    
    case Pedal.Create
    case Pedal.Read
    case Pedal.UpdateName
    case Pedal.UpdateArtist
    case Pedal.Remove
    case Pedal.Knob.Link
    case Pedal.Knob.Unlink
    
    case Tune.Create
    case Tune.Read
    case Tune.UpdateName
    case Tune.UpdateArtist
    case Tune.Remove
    case Tune.Pedal.Link
    case Tune.Pedal.Unlink
    case Tune.Pedal.Knob.UpdateValue
    
    case Knob.Create
    case Knob.Read
    case Knob.UpdateName
    case Knob.Remove
}

enum RequestError: Error {
    case NotAuthenticated
    case AlreadyAuthenticated
    case AuthenticationNotAllowed
    case CredentialsIncorrect
    case EmailAlreadyRegistered
    case UserNotFound
    case TuneNotFound
    case PedalNotFound
    case KnobNotFound
    case PedalAlredyAssociated
    case PedalNotAssociated
    case TuneAlreadyAssociated
    case TuneNotAssociated
    case Unexpected
    
    static func error(forEndpoint: RequestEndpoint, withHttpErrorCode errorCode: Int) -> RequestError {
        switch forEndpoint {
        case Auth.Login:
            
        case Auth.Loggout:
            return .Unexpected
        case User.Create:
            
        case User.Read:
            
        case User.UpdateName:
            return .Unexpected
        case User.Remove:
            return .Unexpected
        case User.Pedal.Link:
            return .Unexpected
        case User.Pedal.Unlink:
            return .Unexpected
        case User.Tune.Link:
            return .Unexpected
        case User.Tune.Unlink:
            return .Unexpected
        case Pedal.Create:
            return .Unexpected
        case Pedal.Read:
            
        case Pedal.UpdateName:
            return .Unexpected
        case Pedal.UpdateArtist:
            return .Unexpected
        case Pedal.Remove:
            return .Unexpected
        case Pedal.Knob.Link:
            return .Unexpected
        case Pedal.Knob.Unlink:
            return .Unexpected
        case Tune.Create:
            
        case Tune.Read:
            return .Unexpected
        case Tune.UpdateName:
            return .Unexpected
        case Tune.UpdateArtist:
            return .Unexpected
        case Tune.Remove:
            return .Unexpected
        case Tune.Pedal.Link:
            return .Unexpected
        case Tune.Pedal.Unlink:
            return .Unexpected
        case Tune.Pedal.Knob.UpdateValue:
            return .Unexpected
        case Knob.Create:
            return .Unexpected
        case Knob.Read:
            return .Unexpected
        case Knob.UpdateName:
            return .Unexpected
        case Knob.Remove:
           return. .Unexpected
        }
    }
}
