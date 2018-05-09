//
//  EditProfileViewModelProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 02/05/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileViewModelProtocol {
    
    func getUserName() -> String
    
    func getUserEmail() -> String
    
    func getUserImage() -> UIImage
    
    func setUserImage(_ image: UIImage)
    
    func updateUser(withCompletionBlock: @escaping () -> Void)
}
