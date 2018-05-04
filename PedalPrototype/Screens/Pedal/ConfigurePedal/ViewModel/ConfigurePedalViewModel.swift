//
//  CreatePedalViewModel.swift
//  PedalPrototype
//
//  Created by Matheus Coelho Berger on 04/03/18.
//  Copyright © 2018 mcb3. All rights reserved.
//

import UIKit
import PromiseKit

class ConfigurePedalViewModel: ConfigurePedalViewModelProtocol {
    
    var pedal: Pedal!
    
    init(withPedal pedal: Pedal?) {
        if let pedal = pedal {
            self.pedal = pedal
        }
    }
    
    func configurePedal(withName name: String,
                        andKnobs knobNames: [String],
                        withCompletionBlock completionBlock: @escaping (Pedal) -> Void) {
        
        guard let user = PBUserProvider.getCurrentUser() else {
            return
        }
        
        if self.isEditingPedal() {
            
            var requests: [Promise<Void>] = []
            
            if name != self.pedal.name {
                self.pedal.name = name
                requests.append(PedalProvider.updateName(pedal: self.pedal))
            }
            
            //Updated Knobs
            for i in 0..<self.pedal.knobs.count {
                let associatedKnob = self.pedal.knobs[i]
                
                if i < knobNames.count {
                    let possibleNewKnobName = knobNames[i]
                    
                    if associatedKnob.name != possibleNewKnobName {
                        associatedKnob.name = possibleNewKnobName
                        requests.append(KnobProvider.updateName(knob: associatedKnob))
                    }
                }
            }
            
            //Added Knobs
            if self.pedal.knobs.count < knobNames.count {
                
                for i in self.pedal.knobs.count..<knobNames.count {
                    let newKnobName = knobNames[i]
                    
                    let createKnobRequest = KnobProvider.create(withName: newKnobName)
                    let pedalAssociateKnobRequest = createKnobRequest.then { knob -> Promise<Void> in
                        self.pedal.knobs.append(knob)
                        return PedalProvider.associate(knob: knob, withPedal: self.pedal)
                    }
                    
                    requests.append(pedalAssociateKnobRequest)
                }
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            when(fulfilled: requests).done {
                completionBlock(self.pedal)
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }.catch { error in
                let error = error as NSError
                if let requestEndpoint = RequestEndpoint(rawValue: error.domain) {
                    let requestError = RequestError.from(endpoint: requestEndpoint, withHttpErrorCode: error.code)
                    //TODO: handle requestError!
                }
            }
            
        } else {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            let requestKnobs = knobNames.map { (knobName) in
               return KnobProvider.create(withName: knobName)
            }
            
            when(fulfilled: requestKnobs).then { knobs in
                PedalProvider.create(withName: name, andKnobs: knobs)
            }.then { pedal -> Promise<Void> in
                self.pedal = pedal
                return PBUserProvider.associate(user: user, withPedal: pedal)
            }.done {
                completionBlock(self.pedal)
            }.ensure {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }.catch { error in 
                let error = error as NSError
                if let requestEndpoint = RequestEndpoint(rawValue: error.domain) {
                    let requestError = RequestError.from(endpoint: requestEndpoint, withHttpErrorCode: error.code)
                    //TODO: handle requestError!
                }
            }
        }
    }
    
    func getPedalName() -> String {
        
        guard let pedal = self.pedal else {
            return ""
        }
        return pedal.name
    }
    
    func isEditingPedal() -> Bool {
        return self.pedal != nil
    }
    
    func getKnobs(withContinuousBlock continuousBlock: @escaping (String) -> Void) {
        
        guard let pedal = self.pedal else {
            return
        }
        
        for knob in pedal.knobs {
            continuousBlock(knob.name)
        }
    }
}
