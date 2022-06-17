//
//  Mute.swift
//  Four Brains
//
//  Created by Marcus Kim on 3/4/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Mute {
    
    private var rideMuteState: Bool = false
    private var snareMuteState: Bool = false
    private var kickMuteState: Bool = false
    private var hatMuteState: Bool = false
    
    public func getRideMuteState() -> Bool {
        return rideMuteState
    }
    
    public func getSnareMuteState() -> Bool {
        return snareMuteState
    }
    
    public func getKickMuteState() -> Bool {
        return kickMuteState
    }
    
    public func getHatMuteState() -> Bool {
        return hatMuteState
    }
    
    func changeMuteState(instrument: String) {
        
        // Perfect place for toggleables
        switch instrument {
        case K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON:
            rideMuteState.toggle()
            
            print("rideMuteState is \(rideMuteState)")
            
        case K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON:
            snareMuteState.toggle()
            
            print("snareMuteState is \(snareMuteState)")
            
        case K.MuteConstants.MuteButtonNames.KICK_MUTE_BUTTON:
            kickMuteState.toggle()
            
            print("bassMuteState is \(kickMuteState)")
            
        case K.MuteConstants.MuteButtonNames.HAT_MUTE_BUTTON:
            hatMuteState.toggle()
            print("hiHatMuteState is \(hatMuteState)")
            
        default:
            print("Error: button title not matched in switch statement")
        }
    }
    
    func unmuteAllStates() {
        rideMuteState = false
        snareMuteState = false
        kickMuteState = false
        hatMuteState = false
        print("unmuteAllStates() called")
    }
    
}
