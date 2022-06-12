//
//  Randomization.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Randomization {
    
    // arrays of beat cards, each instrument pattern will hold at maximum 4 beat card objects
    private var ridePattern: [BeatCard] = []
    private var snarePattern: [BeatCard] = []
    private var bassPattern: [BeatCard] = []
    private var hiHatPattern: [BeatCard] = []
    
    func randomize(beatCardInstances: K.BeatCardInstances, drumSounds: DrumSounds) -> WholeBeat{
        
        // reset patterns to blank arrays
        ridePattern = []
        snarePattern = []
        bassPattern = []
        hiHatPattern = []
        
        //with every loop, append a random beat card to the instrument pattern, until 4 beats cards are added
        for _ in Range(0...3) {
            ridePattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            snarePattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            bassPattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            hiHatPattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            }
    
        //return a freshly instantiated Whole Beat object, which is initialized with 4 parameters, each of which is an array of 4 random beat cards
        let wholeBeat = WholeBeat(ridePattern: self.ridePattern, snarePattern: self.snarePattern, bassPattern: self.bassPattern, hiHatPattern: self.hiHatPattern)
        
        return wholeBeat
        
    }
        
    
    
}
