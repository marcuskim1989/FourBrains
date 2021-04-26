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
    var metronome: Metronome!
    var drumSounds: DrumSounds!
    var mute: Mute!
    let mixer = Mixer()
    
    init(metronome: Metronome, drumSounds: DrumSounds) {
        
        //let metronomeBooster = Fader(metronome.sequencer)
        //metronomeBooster.rightGain = 0
        //let metronomeBoosterLeftPan = Panner(metronomeBooster, pan: -1)
        
        //let drumBooster = Fader(drumSounds.drums)
        //drumBooster.gain = 20
        //let drumBoosterRightPan = Panner(drumBooster, pan: 1)
        //drumBoosterRightPan.bypass()
        
        self.metronome = metronome
        self.drumSounds = drumSounds
        
    }
    
    @discardableResult
    func changeIsPlaying() -> Bool{
        if isPlaying {
            isPlaying = false
        } else {
            isPlaying = true
        }
        
        print("isPlaying inside changeIsPlaying(): \(isPlaying)")
        return isPlaying
    }
    
    func play() {
        
        //print(metronome.metronomeToggleState)
        if isPlaying{
            print("isPlaying inside if inside play(): \(isPlaying)")
//            do {
//                try engine.start()
//            } catch {
//                print("AudioKit did not start.")
//            }
            //metronome.playMetronome()
            drumSounds.playDrumSounds()
            
            
        } else {
            print("isPlaying inside else inside play(): \(isPlaying)")
            
            //metronome.stopMetronome()
            drumSounds.stopDrumsSounds()
//            engine.stop()
            
        }
        
        
    }
    
    
}

    

