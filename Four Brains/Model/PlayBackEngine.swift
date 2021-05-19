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
    
    private var isPlaying = false
    private var metronome: Metronome!
    private var drumSounds: DrumSounds!
    
    init(metronome: Metronome, drumSounds: DrumSounds) {
        
        self.metronome = metronome
        self.drumSounds = drumSounds
        
    }
    
    public func getIsPlaying() -> Bool {
        return isPlaying
    }
    
    //perfect place to use a toggleable
    @discardableResult
    func changeIsPlaying() -> Bool{
        
        isPlaying.toggle()
        
        print("isPlaying inside changeIsPlaying(): \(!isPlaying)")
        return isPlaying
    }
    
    
    
    func play() {
        
        //print(metronome.metronomeToggleState)
        if isPlaying{
            print("isPlaying inside if inside play(): \(isPlaying)")
            
            metronome.playMetronome()
            drumSounds.playDrumSounds()
            
            
        } else {
            print("isPlaying inside else inside play(): \(isPlaying)")
            
            metronome.stopMetronome()
            drumSounds.stopDrumsSounds()
            
        }
        
        
    }
    
    
}

    

