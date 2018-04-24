//
//  AuthRequestError.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

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
    case ParametersInvalid
    case ServerCouldNotProcess
    case Unexpected
    
    static func from(endpoint: RequestEndpoint, withHttpErrorCode errorCode: Int) -> RequestError {
        
        switch errorCode {
        case 422:
            return .ParametersInvalid
        case 500:
            return .ServerCouldNotProcess
        case 501:
            return .Unexpected
        default:
            break
        }
        
        switch endpoint {
            
        case .Auth_Login:
            switch errorCode {
            case 401:
                return .AlreadyAuthenticated
            case 403:
                return .CredentialsIncorrect
            case 404:
                return .UserNotFound
            default:
                break
            }
            
        case .Auth_Loggout:
            return .Unexpected
            
        case .User_Create:
            switch errorCode {
            case 403:
                return .EmailAlreadyRegistered
            default:
                break
            }
            
        case .User_Read:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .UserNotFound
            default:
                break
            }
            
        case .User_UpdateName:
            return .Unexpected
            
        case .User_Remove:
            return .Unexpected
            
        case .User_Pedal_Link:
            return .Unexpected
            
        case .User_Pedal_Unlink:
            return .Unexpected
            
        case .User_Tune_Link:
            return .Unexpected
            
        case .User_Tune_Unlink:
            return .Unexpected
            
        case .Pedal_Create:
            return .Unexpected
            
        case .Pedal_Read:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .PedalNotFound
            default:
                break
            }
            
        case .Pedal_UpdateName:
            return .Unexpected
            
        case .Pedal_UpdateArtist:
            return .Unexpected
            
        case .Pedal_Remove:
            return .Unexpected
            
        case .Pedal_Knob_Link:
            return .Unexpected
            
        case .Pedal_Knob_Unlink:
            return .Unexpected
            
        case .Tune_Create:
            return .Unexpected
            
        case .Tune_Read:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .TuneNotFound
            default:
                break
            }
            
        case .Tune_UpdateName:
            return .Unexpected
            
        case .Tune_UpdateArtist:
            return .Unexpected
            
        case .Tune_Remove:
            return .Unexpected
            
        case .Tune_Pedal_Link:
            return .Unexpected
            
        case .Tune_Pedal_Unlink:
            return .Unexpected
            
        case .Tune_Pedal_Knob_UpdateValue:
            return .Unexpected
            
        case .Knob_Create:
            return .Unexpected
            
        case .Knob_Read:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .KnobNotFound
            default:
                break
            }
            
        case .Knob_UpdateName:
            return .Unexpected
            
        case .Knob_Remove:
           return .Unexpected
            
        }
        
        return .Unexpected
    }
}
