//
//  Snooze.swift
//  Four Brains
//
//  Created by Marcus Kim on 3/4/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Snooze {
    
    private var rideSnoozeState: Bool = false
    private var snareSnoozeState: Bool = false
    private var bassSnoozeState: Bool = false
    private var hiHatSnoozeState: Bool = false
    private var mute: Mute!
    private var drumSounds: DrumSounds!
    
    init (mute: Mute, drumSounds: DrumSounds) {
        self.mute = mute
        self.drumSounds = drumSounds
    }
    
    public func getRideSnoozeState() -> Bool {
        return rideSnoozeState
    }
    
    public func getSnareSnoozeState() -> Bool {
        return snareSnoozeState
    }
    
    public func getBassSnoozeState() -> Bool {
        return bassSnoozeState
    }
    
    public func getHiHatSnoozeState() -> Bool {
        return hiHatSnoozeState
    }
    
    func changeSnoozeState(instrument: String){
        
        switch instrument {
        case K.SNOOZECONSTANTS.RIDE_SNOOZE_BUTTON:
                if rideSnoozeState{
                    rideSnoozeState = false
                    
                } else {
                    rideSnoozeState = true
                    
            }
            
            
        case K.SNOOZECONSTANTS.SNARE_SNOOZE_BUTTON:
                if snareSnoozeState{
                    snareSnoozeState = false
                } else {
                    snareSnoozeState = true
            }
            
            
        case K.SNOOZECONSTANTS.BASS_SNOOZE_BUTTON:
                if bassSnoozeState{
                    bassSnoozeState = false
                } else {
                    bassSnoozeState = true
            }
            
            
        case K.SNOOZECONSTANTS.HI_HAT_SNOOZE_BUTTON:
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
