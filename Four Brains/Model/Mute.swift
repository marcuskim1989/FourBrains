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
        case K.MUTECONSTANTS.RIDE_MUTE_BUTTON:
                if rideMuteState{
                        rideMuteState = false
                    } else {
                        rideMuteState = true
                }
           print("rideMuteState is \(rideMuteState)")
            
        case K.MUTECONSTANTS.SNARE_MUTE_BUTTON:
                if snareMuteState{
                    snareMuteState = false
                } else {
                    snareMuteState = true
            }
            print("snareMuteState is \(snareMuteState)")
            
        case K.MUTECONSTANTS.BASS_MUTE_BUTTON:
                if bassMuteState{
                    bassMuteState = false
                } else {
                    bassMuteState = true
            }
            print("bassMuteState is \(bassMuteState)")
            
        case K.MUTECONSTANTS.HI_HAT_MUTE_BUTTON:
                if hiHatMuteState{
                    hiHatMuteState = false
                } else {
                    hiHatMuteState = true
            }
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
