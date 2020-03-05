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
    
    
    init(metronome: Metronome, drumSounds: DrumSounds) {
        /*
        let metronomeBooster = AKBooster(metronome.metronome)
        metronomeBooster.rightGain = 0
        let metronomeBoosterLeftPan = AKPanner(metronomeBooster, pan: -1)
        
        let drumBooster = AKBooster(drumSounds.drums)
        drumBooster.leftGain = 0
        let drumBoosterRightPan = AKPanner(drumBooster, pan: 1)
        drumBoosterRightPan.bypass()
        
        
        let mixer = AKMixer(metronomeBoosterLeftPan, drumBoosterRightPan)
        */
        
        let mixer = AKDryWetMixer(metronome.metronome, drumSounds.drums, balance: 0.5)
        AudioKit.output = mixer
        
        
    }
    
    func changeIsPlaying() -> Bool{
        if isPlaying {
            isPlaying = false
        } else {
            isPlaying = true
        }
        
        print("isPlaying inside changeIsPlaying(): \(isPlaying)")
        return isPlaying
    }
    
    func play(metronome: Metronome, drumSounds: DrumSounds) {
        
        //print(metronome.metronomeToggleState)
        if isPlaying{
            print("isPlaying inside if inside play(): \(isPlaying)")
            metronome.playMetronome()
            
        } else {
            print("isPlaying inside else inside play(): \(isPlaying)")
            
            metronome.metronome.stop()
            metronome.metronome.reset()
            
        }
        
        drumSounds.playDrumSounds()
        
    }
    
    
}

    

