//
//  PlayBackEngine.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit

class PlayBackEngine {
    
    var isPlaying = false
    
    func changeIsPlaying() -> Bool{
        if isPlaying {
            isPlaying = false
        } else {
            isPlaying = true
        }
        
        print("isPlaying inside changeIsPlaying(): \(isPlaying)")
        return isPlaying
    }
    
    func play(metronome: Metronome) {
        
        //print(metronome.metronomeToggleState)
        if isPlaying{
            print("isPlaying inside if inside play(): \(isPlaying)")
            metronome.playMetronome()
        } else {
            print("isPlaying inside else inside play(): \(isPlaying)")
            
            metronome.metronome.stop()
            metronome.metronome.reset()
            
        }
        
    
    }
    
    
        
}
    

