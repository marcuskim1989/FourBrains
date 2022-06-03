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
    private var bassMuteState: Bool = false
    private var hiHatMuteState: Bool = false
    
    public func getRideMuteState() -> Bool {
        return rideMuteState
    }
    
    public func getSnareMuteState() -> Bool {
        return snareMuteState
    }
    
    public func getBassMuteState() -> Bool {
        return bassMuteState
    }
    
    public func getHiHatMuteState() -> Bool {
        return hiHatMuteState
    }
    
    func changeMuteState(instrument: String) {
        
        //Perfect place for toggleables
        switch instrument {
        case K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON:
            rideMuteState.toggle()
            
            print("rideMuteState is \(rideMuteState)")
            
        case K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON:
            snareMuteState.toggle()
            
            print("snareMuteState is \(snareMuteState)")
            
        case K.MuteConstants.MuteButtonNames.BASS_MUTE_BUTTON:
            bassMuteState.toggle()
            
            print("bassMuteState is \(bassMuteState)")
            
        case K.MuteConstants.MuteButtonNames.HI_HAT_MUTE_BUTTON:
            hiHatMuteState.toggle()
            print("hiHatMuteState is \(hiHatMuteState)")
            
        default:
            print("Error: button title not matched in switch statement")
        }
    }
    
    func unmuteAllStates() {
        rideMuteState = false
        snareMuteState = false
        bassMuteState = false
        hiHatMuteState = false
        print("unmuteAllStates() called")
    }
    
}
