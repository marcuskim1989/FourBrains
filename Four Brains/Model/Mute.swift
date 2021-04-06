//
//  Mute.swift
//  Four Brains
//
//  Created by Marcus Kim on 3/4/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Mute {
    
    var rideMuteState: Bool = false
    var snareMuteState: Bool = false
    var bassMuteState: Bool = false
    var hiHatMuteState: Bool = false
    
    
    
    init() {
        
    }
    
    func changeMuteState(instrument: String) {
        
        switch instrument {
        case K.MUTECONSTANTS.RIDE_MUTE_BUTTON:
                if rideMuteState{
                        rideMuteState = false
                    } else {
                        rideMuteState = true
                }
           // return rideMuteState
            
        case K.MUTECONSTANTS.SNARE_MUTE_BUTTON:
                if snareMuteState{
                    snareMuteState = false
                } else {
                    snareMuteState = true
            }
            //return snareMuteState
            
        case K.MUTECONSTANTS.BASS_MUTE_BUTTON:
                if bassMuteState{
                    bassMuteState = false
                } else {
                    bassMuteState = true
            }
            //return bassMuteState
            
        case K.MUTECONSTANTS.HI_HAT_MUTE_BUTTON:
                if hiHatMuteState{
                    hiHatMuteState = false
                } else {
                    hiHatMuteState = true
            }
           // return hiHatMuteState
            
            default:
                print("Error: button title not matched in switch statement, returning `false`")
           // return false
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
