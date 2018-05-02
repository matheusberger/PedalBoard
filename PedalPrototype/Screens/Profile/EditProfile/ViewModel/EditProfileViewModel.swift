//
//  EditProfileViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewModel: EditProfileViewModelProtocol {
    
    var user: PBUser
    
    init() {
        self.user = PBUserProvider.getCurrentUser()!
    }
    
    func getUserName() -> String {
        return self.user.fullName
    }
    
    func getUserEmail() -> String {
        return self.user.email
    }
    
    func getUserPicture() -> UIImage {
        return UIImage()
    }
    
    func updateUser(withCompletionBlock completionBlock: @escaping () -> Void) {
        PBUserProvider.update(user: self.user) { (error) in
            if error == nil {
                completionBlock()
            }
            else {
                print(error!)
            }
        }
    }
}
