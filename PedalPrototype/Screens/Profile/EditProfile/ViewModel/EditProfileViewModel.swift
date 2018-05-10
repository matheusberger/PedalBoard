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
        self.user = PBUserProvider.getCurrentUser()
    }
    
    func getUserName() -> String {
        return self.user.fullName
    }
    
    func getUserEmail() -> String {
        return self.user.email
    }
    
    func getUserImage() -> UIImage {
        
        guard let imgData = self.user.picture else {
            return UIImage()
        }
        
        guard let image = UIImage(data: imgData) else {
            return UIImage()
        }
        
        return image
    }
    
    func setUserImage(_ image: UIImage) {
        let data = UIImageJPEGRepresentation(image, 1)
        self.user.picture = data
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
