//
//  Randomization.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Randomization {
    
    private var ridePattern: [BeatCard] = []
    private var snarePattern: [BeatCard] = []
    private var bassPattern: [BeatCard] = []
    private var hiHatPattern: [BeatCard] = []
    
    func randomize(beatCardInstances: K.BEATCARDINSTANCES, drumSounds: DrumSounds) -> WholeBeat{
        
        ridePattern = []
        snarePattern = []
        bassPattern = []
        hiHatPattern = []
        
        for _ in Range(0...3) {
            ridePattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            snarePattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            bassPattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            hiHatPattern.append(beatCardInstances.BEAT_CARD_ARRAY[Int.random(in: 0...15)])
            }
    
        let wholeBeat = WholeBeat(ridePattern: self.ridePattern, snarePattern: self.snarePattern, bassPattern: self.bassPattern, hiHatPattern: self.hiHatPattern)
        
        return wholeBeat
        
    }
        
    
    
}
