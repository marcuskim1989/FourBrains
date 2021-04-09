//
//  Randomization.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class Randomization {
    
    var ridePattern: [BeatCard] = [BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0])]
    var snarePattern: [BeatCard] = [BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0])]
    var bassPattern: [BeatCard] = [BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0])]
    var hiHatPattern: [BeatCard] = [BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0]), BeatCard(l: "0", ns: [0,0,0,0])]
    
    var wholeBeat = WholeBeat(ridePattern: [BeatCard(l: "0", ns: [0,0,0,0])], snarePattern: [BeatCard(l: "0", ns: [0,0,0,0])], bassPattern: [BeatCard(l: "0", ns: [0,0,0,0])], hiHatPattern: [BeatCard(l: "0", ns: [0,0,0,0])])
    
    
    func randomize(beatCardInstances: BeatCardInstances, drumSounds: DrumSounds) -> WholeBeat{
        
        
            
        for rideBeatCard in Range(0...ridePattern.count - 1) {
                
                    ridePattern[rideBeatCard] = beatCardInstances.beatCardArray[Int.random(in: 0...15)]
            
            }
            
        for snareBeatCard in Range(0...snarePattern.count - 1) {
                
                    snarePattern[snareBeatCard] = beatCardInstances.beatCardArray[Int.random(in: 0...15)]
                
            }
            
        for bassBeatCard in Range(0...bassPattern.count - 1) {
                
                    bassPattern[bassBeatCard] = beatCardInstances.beatCardArray[Int.random(in: 0...15)]
                
            }
            
        for hiHatBeatCard in Range(0...hiHatPattern.count - 1) {
                
                    hiHatPattern[hiHatBeatCard] = beatCardInstances.beatCardArray[Int.random(in: 0...15)]
                
            }
            
    
        wholeBeat = WholeBeat(ridePattern: self.ridePattern, snarePattern: self.snarePattern, bassPattern: self.bassPattern, hiHatPattern: self.hiHatPattern)
        
        
        drumSounds.parseNoteSequence(wholeBeat: wholeBeat)
        
        
        
        return wholeBeat
        
    }
        
    
    
}
