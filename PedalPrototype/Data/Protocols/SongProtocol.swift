//
//  SongProtocol.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 21/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import Foundation

protocol SongProtocol {
    
    static func getSongs(forUser: String, withContinuousFetchBlock: @escaping (_ song: Song) -> Void)
    
    static func create(song: Song, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
    
    static func delete(song: Song, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
    
    static func update(song: Song, forUser: String, withCompletionBlock: @escaping (_ success: Bool) -> Void)
}
