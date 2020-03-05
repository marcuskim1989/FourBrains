//
//  Metronome.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit

class Metronome {
    
    var metronome: AKMetronome!
    var metronomeToggleState = true
    //var restartCounter = 0
    
    init(drumSounds: DrumSounds) {
        metronome = AKMetronome()
        
        metronome.callback = {
        /*
            if self.restartCounter == 5
            {
                self.metronome.reset()
                self.restartCounter = 0
            }
            
            self.restartCounter += 1
          */
                /*
                    let deadlineTime = DispatchTime.now() + (60/self.metronome.tempo) / 10.0
                
                    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
                    }
                */
            
            }
    }
    
    
    func changeMetronomeToggleState() -> Bool{
        if metronomeToggleState {
            metronomeToggleState = false
        } else {
            metronomeToggleState = true
        }
        
        print("metronomeToggleState inside changeMetronomeToggleState: \(metronomeToggleState)")
        return metronomeToggleState
    }
    
    func playMetronome(){
        
        if metronomeToggleState{
            print("metronomeToggleState inside if inside playMetronome(): \(metronomeToggleState)")
            
            metronome.start()
        } else {
            print("metronomeToggleState inside if inside playMetronome(): \(metronomeToggleState)")
            metronome.stop()
            metronome.reset()
        }
        
        
    }
    
    
}
