//
//  User+Firebase.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 18/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import SwiftyJSON

extension PBUser {
    
    static func from(jsonString: String) -> PBUser? {
        
        guard let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) else {
            return nil
        }
        
        guard let json: JSON = try? JSON(data: dataFromString) else {
            return nil
        }
        
        return PBUser.from(data: json)
    }
    
    static func from(data: JSON) -> PBUser? {
        
        guard let id = data["_id"].string else {
            return nil
        }
        
        guard let email = data["email"].string else {
            return nil
        }
        
        guard let name = data["name"].string else {
            return nil
        }
        
        guard let pedalsId = data["pedals"].array else {
            return nil
        }
        
        guard let tunesId = data["tunes"].array else {
            return nil
        }
        
        let pedals = pedalsId.map { (jsonId) -> String in
            return jsonId.string ?? ""
        }
        
        let tunes = tunesId.map { (jsonId) -> String in
            return jsonId.string ?? ""
        }
        
        return PBUser(withID: id, withEmail: email, withName: name, withPedalsId: pedals, withTunesId: tunes)
    }
    
    func toJSONString() -> String {
        
        let json: JSON = [
            "_id": self.id,
            "email": self.email,
            "name": self.name,
            "pedals": self.pedalsId,
            "tunes": self.tunesId
        ]
        
        return json.rawString()!
    }
}
