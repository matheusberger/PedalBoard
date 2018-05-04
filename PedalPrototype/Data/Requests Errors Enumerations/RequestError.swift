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
    
    case KnobAlreadyAssociated
    case PedalAlreadyAssociated
    case TuneAlreadyAssociated
    
    case KnobNotAssociated
    case PedalNotAssociated
    case TuneNotAssociated
    
    case KnobLinkedToPedal
    case PedalLinkedToTune
    case PedalLinkedToUser
    case TuneLinkedToUser
    
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
            switch errorCode {
            case 401:
                return .NotAuthenticated
            default:
                break
            }
            
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
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .PedalNotFound
            case 409:
                return .AuthenticationNotAllowed
            case 403:
                return .PedalAlreadyAssociated
            default: break
            }
            
        case .User_Pedal_Unlink:
            return .Unexpected
            
        case .User_Tune_Link:
            return .Unexpected
            
        case .User_Tune_Unlink:
            return .Unexpected
            
        case .Pedal_Create:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            default:
                break
            }
            
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
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .PedalNotFound
            case 409:
                return .AuthenticationNotAllowed
            default:
                break
            }
            
        case .Pedal_UpdateArtist:
            return .Unexpected
            
        case .Pedal_Remove:
            return .Unexpected
            
        case .Pedal_Knob_Link:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 403:
                return .KnobAlreadyAssociated
            case 404:
                return .PedalNotFound
            case 409:
                return .AuthenticationNotAllowed
            default:
                break
            }
            
        case .Pedal_Knob_Unlink:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 403:
                return .KnobNotAssociated
            case 404:
                return .PedalNotFound
            case 409:
                return .AuthenticationNotAllowed
            default:
                break
            }
            
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
            switch errorCode {
            case 401:
                return .NotAuthenticated
            default:
                break
            }
            
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
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 404:
                return .KnobNotFound
            case 409:
                return .AuthenticationNotAllowed
            default:
                break
            }
            
        case .Knob_Remove:
            switch errorCode {
            case 401:
                return .NotAuthenticated
            case 403:
                return .KnobLinkedToPedal
            case 404:
                return .KnobNotFound
            case 409:
                return .AuthenticationNotAllowed
            default:
                break
            }
            
        }
        
        return .Unexpected
    }
}
