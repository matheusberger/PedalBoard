//
//  RequestEndpoint.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

enum RequestEndpoint: String {
    case Auth_Login = "Auth_Login"
    case Auth_Loggout = "Auth_Loggout"
    
    case User_Create = "User_Create"
    case User_Read = "User_Read"
    case User_UpdateName = "User_UpdateName"
    case User_Remove = "User_Remove"
    case User_Pedal_Link = "User_Pedal_Link"
    case User_Pedal_Unlink = "User_Pedal_Unlink"
    case User_Tune_Link = "User_Tune_Link"
    case User_Tune_Unlink = "User_Tune_Unlink"
    
    case Pedal_Create = "Pedal_Create"
    case Pedal_Read = "Pedal_Read"
    case Pedal_UpdateName = "Pedal_UpdateName"
    case Pedal_UpdateArtist = "Pedal_UpdateArtist"
    case Pedal_Remove = "Pedal_Remove"
    case Pedal_Knob_Link = "Pedal_Knob_Link"
    case Pedal_Knob_Unlink = "Pedal_Knob_Unlink"
    
    case Tune_Create = "Tune_Create"
    case Tune_Read = "Tune_Read"
    case Tune_UpdateName = "Tune_UpdateName"
    case Tune_UpdateArtist = "Tune_UpdateArtist"
    case Tune_Remove = "Tune_Remove"
    case Tune_Pedal_Link = "Tune_Pedal_Link"
    case Tune_Pedal_Unlink = "Tune_Pedal_Unlink"
    case Tune_Pedal_Knob_UpdateValue = "Tune_Pedal_Knob_UpdateValue"
    
    case Knob_Create = "Knob_Create"
    case Knob_Read = "Knob_Read"
    case Knob_UpdateName = "Knob_UpdateName"
    case Knob_Remove = "Knob_Remove"
}
