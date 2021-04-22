//
//  BeatCardInstances.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class BeatCardInstances {
    let beatCard0 = BeatCard(label: "0", noteSequence: [0,0,0,0])
    let beatCard1A = BeatCard(label: "1A", noteSequence: [1,0,0,0])
    let beatCard1B = BeatCard(label: "1B", noteSequence: [0,1,0,0])
    let beatCard1C = BeatCard(label: "1C", noteSequence: [0,0,1,0])
    let beatCard1D = BeatCard(label: "1D", noteSequence: [0,0,0,1])
    let beatCard2A = BeatCard(label: "2A", noteSequence: [1,1,0,0])
    let beatCard2B = BeatCard(label: "2B", noteSequence: [0,1,1,0])
    let beatCard2C = BeatCard(label: "2C", noteSequence: [0,0,1,1])
    let beatCard2D = BeatCard(label: "2D", noteSequence: [1,0,0,1])
    let beatCard2E = BeatCard(label: "2E", noteSequence: [1,0,1,0])
    let beatCard2F = BeatCard(label: "2F", noteSequence: [0,1,0,1])
    let beatCard3A = BeatCard(label: "3A", noteSequence: [1,1,1,0])
    let beatCard3B = BeatCard(label: "3B", noteSequence: [1,1,0,1])
    let beatCard3C = BeatCard(label: "3C", noteSequence: [1,0,1,1])
    let beatCard3D = BeatCard(label: "3D", noteSequence: [0,1,1,1])
    let beatCard4 = BeatCard(label: "4", noteSequence: [1,1,1,1])
    
    var beatCardArray: [BeatCard]
    
    init() {
        beatCardArray = [beatCard0,
                         beatCard1A, beatCard1B, beatCard1C, beatCard1D,
                         beatCard2A, beatCard2B, beatCard2C, beatCard2D, beatCard2E, beatCard2F,
                         beatCard3A, beatCard3B, beatCard3C, beatCard3D,
                         beatCard4]
    }
    
}
