//
//  Snooze.swift
//  Four Brains
//
//  Created by Marcus Kim on 3/4/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Snooze {
    
    var rideSnoozeState: Bool = false
    var snareSnoozeState: Bool = false
    var bassSnoozeState: Bool = false
    var hiHatSnoozeState: Bool = false
    var mute: Mute!
    var drumSounds: DrumSounds!
    
    init (mute: Mute, drumSounds: DrumSounds) {
        self.mute = mute
        self.drumSounds = drumSounds
    }
    
    func changeSnoozeState(instrument: String){
        
        switch instrument {
            case "rideSnooze":
                if rideSnoozeState{
                    rideSnoozeState = false
                    
                } else {
                    rideSnoozeState = true
                    
            }
            
            
            case "snareSnooze":
                if snareSnoozeState{
                    snareSnoozeState = false
                } else {
                    snareSnoozeState = true
            }
            
            
            case "bassSnooze":
                if bassSnoozeState{
                    bassSnoozeState = false
                } else {
                    bassSnoozeState = true
            }
            
            
            case "hiHatSnooze":
                if hiHatSnoozeState{
                    hiHatSnoozeState = false
                } else {
                    hiHatSnoozeState = true
            }
            
            
            default:
                print("Error in changeSnoozeState: button title not matched in switch statement")
            
        }
        
    }
    
    func unsnoozeAllStates() {
        rideSnoozeState = false
        snareSnoozeState = false
        bassSnoozeState = false
        hiHatSnoozeState = false
        
        print("unsnoozeAllStates() called")
    }
    
}
