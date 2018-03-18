//
//  User.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 17/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

class PBUser {
    
    var uid: String?
    
    var email: String
    var firstName: String
    var surname: String
    
    var fullName: String {
        return self.firstName + " " + self.surname
    }
    
    init(withUID uid: String? = nil,
         withEmail email: String,
         withFirstName firstName: String,
         andSurname surname: String? = "") {
        
        self.uid = uid
        
        self.email = email
        self.firstName = firstName
        self.surname = surname!
    }
}
