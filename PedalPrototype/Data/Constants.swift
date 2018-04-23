//
//  Constants.swift
//  PedalPrototype
//
//  Created by Daniel Barbosa Maranhão on 23/04/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class Constants {
    
    class API {
        
        static let URL = "http://54.207.23.31:3000"
        
        //Auth Requests
        static let URL_AUTH = Constants.API.URL + "/auth"
        
        //User Requests
        static let URL_USER = Constants.API.URL + "/user"
        static let URL_USER_ID = Constants.API.URL_USER + "/%@"
        static let URL_USER_ID_NAME = Constants.API.URL_USER_ID + "/name"
        static let URL_USER_ID_PEDAL_ID = Constants.API.URL_USER_ID + "/pedal/%@"
        static let URL_USER_ID_TUNE_ID = Constants.API.URL_USER_ID + "/tune/%@"
        
        //Pedal Requests
        static let URL_PEDAL = Constants.API.URL + "/pedal"
        static let URL_PEDAL_ID = Constants.API.URL_PEDAL + "/%@"
        static let URL_PEDAL_ID_NAME = Constants.API.URL_PEDAL_ID + "/name"
        static let URL_PEDAL_ID_KNOB_ID = Constants.API.URL_PEDAL_ID + "/knob/%@"
        
        //Tune Requests
        static let URL_TUNE = Constants.API.URL + "/tune"
        static let URL_TUNE_ID = Constants.API.URL_TUNE + "/%@"
        static let URL_TUNE_ID_NAME = Constants.API.URL_TUNE_ID + "/name"
        static let URL_TUNE_ID_ARTIST = Constants.API.URL_TUNE_ID + "/artist"
        static let URL_TUNE_ID_PEDAL_ID = Constants.API.URL_TUNE_ID + "/pedal/%@"
        static let URL_TUNE_ID_PEDAL_ID_KNOB_ID_VALUE = Constants.API.URL_TUNE_ID_PEDAL_ID + "/knob/%@/value"
        
        //Knob Requests
        static let URL_KNOB = Constants.API.URL + "/knob"
        static let URL_KNOB_ID = Constants.API.URL_KNOB + "/%@"
        static let URL_KNOB_ID_NAME = Constants.API.URL_KNOB_ID + "/name"
    }
}
