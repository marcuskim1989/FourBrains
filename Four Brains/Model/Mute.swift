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
    
    func changeMuteState(instrument: String) -> Bool {
        
        switch instrument {
            case "rideMuteButton":
                if rideMuteState{
                        rideMuteState = false
                    } else {
                        rideMuteState = true
                }
            return rideMuteState
            
            case "snareMuteButton":
                if snareMuteState{
                    snareMuteState = false
                } else {
                    snareMuteState = true
            }
            return snareMuteState
            
            case "bassMuteButton":
                if bassMuteState{
                    bassMuteState = false
                } else {
                    bassMuteState = true
            }
            return bassMuteState
            
            case "hiHatMuteButton":
                if hiHatMuteState{
                    hiHatMuteState = false
                } else {
                    hiHatMuteState = true
            }
            return hiHatMuteState
            
            default:
                print("Error: button title not matched in switch statement, returning `false`")
            return false
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
